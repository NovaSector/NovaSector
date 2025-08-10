import * as autoLabelConfig from "./autoLabelConfig.js";

/**
 * Precompute a lowercase keyword → changelog label map
 */
const keywordToClLabel = (() => {
  const map = {};
  for (const [label, { keywords }] of Object.entries(
    autoLabelConfig.changelog_labels
  )) {
    for (const keyword of keywords) {
      map[keyword.toLowerCase()] = label;
    }
  }
  return map;
})();

/**
 * Precompute title keyword Sets per label for O(1) lookup
 */
const titleKeywordSets = (() => {
  const map = {};
  for (const [label, { keywords }] of Object.entries(
    autoLabelConfig.title_labels
  )) {
    map[label] = new Set(keywords.map((k) => k.toLowerCase()));
  }
  return map;
})();

/**
 * Precompute filepaths Sets per label for O(1) lookup
 */
const fileLabelFilepathSets = (() => {
  const map = {};
  for (const [label, { filepaths, add_only }] of Object.entries(
    autoLabelConfig.file_labels
  )) {
    map[label] = { filepaths: new Set(filepaths), add_only };
  }
  return map;
})();

/**
 * Checks the body (primarily the changelog) for labels to add
 */
function check_body_for_labels(body) {
  const labels_to_add = [];

  // detect "fixes #1234" or "resolves #1234" in body
  const fix_regex = /\b(?:fix(?:es|ed)?|resolve[sd]?)\s*#\d+\b/gim;
  if (fix_regex.test(body)) {
    labels_to_add.push("Fix");
  }

  const lines = body.split("\n");
  let inChangelog = false;

  for (const line of lines) {
    if (line.startsWith(":cl:")) {
      inChangelog = true;
      continue;
    }
    if (line.startsWith("/:cl:")) break;
    if (!inChangelog) continue;

    // see if the first segment of the line is one of the keywords
    const keyword = line.split(":")[0]?.toLowerCase();
    const found_label = keywordToClLabel[keyword];
    if (!found_label) continue;

    // don't add a billion tags if they forgot to clear all the default ones
    const line_text = line.split(":")[1]?.trim();
    const { default_text, alt_default_text } =
      autoLabelConfig.changelog_labels[found_label];

    if (line_text !== default_text && line_text !== alt_default_text) {
      labels_to_add.push(found_label);
    }
  }

  return labels_to_add;
}

/**
 * Checks the title for labels to add (O(1) keyword lookup)
 */
function check_title_for_labels(title) {
  const title_lower = title.toLowerCase();
  const labels_to_add = [];

  for (const [label, keywordSet] of Object.entries(titleKeywordSets)) {
    for (const keyword of keywordSet) {
      if (title_lower.includes(keyword)) {
        labels_to_add.push(label);
        break;
      }
    }
  }
  return labels_to_add;
}

/**
 * Checks changed files for labels to add/remove with pagination support
 */
async function check_diff_files_for_labels(github, context) {
  const labels_to_add = [];
  const labels_to_remove = [];
  const per_page = 100; // Maximum per page
  let page = 1;
  let has_more_files = true;

  try {
    while (has_more_files) {
      const { status, data, headers } = await github.rest.pulls.listFiles({
        owner: context.repo.owner,
        repo: context.repo.repo,
        pull_number: context.payload.pull_request.number,
        per_page,
        page,
      });

      if (status !== 200) {
        console.error(`Failed to get file list: ${status}`);
        return { labels_to_add, labels_to_remove };
      }
      if (!data) throw new Error("Response does not contain any data!");

      // Store changed filenames in a Set for O(1) lookup
      const changed_files = new Set(data.map((f) => f.filename));

      for (const [label, { filepaths, add_only }] of Object.entries(
        fileLabelFilepathSets
      )) {
        let found = false;
        for (const filepath of filepaths) {
          for (const filename of changed_files) {
            if (filename.includes(filepath)) {
              found = true;
              break;
            }
          }
          if (found) break;
        }
        if (found) {
          labels_to_add.push(label);
        } else if (!add_only) {
          labels_to_remove.push(label);
        }
      }

      // Check if there's another page
      const linkHeader = headers.link;
      if (linkHeader && linkHeader.includes('rel="next"')) {
        page++;
      } else {
        has_more_files = false;
      }
    }
  } catch (e) {
    console.error(e);
  }

  return { labels_to_add, labels_to_remove };
}

/**
 * Main function to get the updated label set
 */
export async function get_updated_label_set({ github, context }) {
  const { action, pull_request } = context.payload;
  const {
    body = "",
    diff_url,
    labels = [],
    mergeable,
    title = "",
  } = pull_request;

  const updated_labels = new Set(labels.map((l) => l.name));

  // Always check file diffs
  if (diff_url) {
    const { labels_to_add, labels_to_remove } =
      await check_diff_files_for_labels(github, context);
    labels_to_add.forEach((label) => updated_labels.add(label));
    labels_to_remove.forEach((label) => updated_labels.delete(label));
  }

  // Check body/title only when PR is opened, not on sync
  if (action === "opened") {
    if (title)
      check_title_for_labels(title).forEach((label) =>
        updated_labels.add(label)
      );
    if (body)
      check_body_for_labels(body).forEach((label) => updated_labels.add(label));
  }

  // Always remove Test Merge Candidate
  updated_labels.delete("Test Merge Candidate");

  // Handle merge conflict label
  let merge_conflict = mergeable === false;
  // null means it was not reported yet
  // it is not normally included in the payload - a "get" is needed
  if (mergeable === null) {
    try {
      let response = await github.rest.pulls.get({
        owner: context.repo.owner,
        repo: context.repo.repo,
        pull_number: pull_request.number,
      });
      // failed to find? still processing? try again in a few seconds

      if (response.data.mergeable === null) {
        console.log("Awaiting GitHub response for merge status...");
        await new Promise((r) => setTimeout(r, 10000));
        response = await github.rest.pulls.get({
          owner: context.repo.owner,
          repo: context.repo.repo,
          pull_number: pull_request.number,
        });
        if (response.data.mergeable === null) {
          throw new Error("Merge status not available");
        }
      }

      merge_conflict = response.data.mergeable === false;
    } catch (e) {
      console.error(e);
    }
  }

  if (merge_conflict) {
    updated_labels.add("Merge Conflict");
  } else {
    updated_labels.delete("Merge Conflict");
  }

  // return the labels to the action, which will apply it
  return [...updated_labels];
}
