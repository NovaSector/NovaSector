import * as autoLabelConfig from "./autoLabelConfig.js";

// Maps changelog keywords to labels
function keywordToClLabel() {
  const keywordToClLabel = {};
  for (let label in autoLabelConfig.changelog_labels) {
    for (let keyword of autoLabelConfig.changelog_labels[label].keywords) {
      keywordToClLabel[keyword] = label;
    }
  }
  return keywordToClLabel;
}

// Checks the body (primarily the changelog) for labels to add
function checkBodyForLabels(body) {
  const labelsToAdd = [];

  // if the body contains a github "fixes #1234" line, add the Fix tag
  const fixRegex = new RegExp(`(fix[des]*|resolve[sd]*)\\s*#\\d+`, "gmi");
  if (fixRegex.test(body)) {
    labelsToAdd.push("Fix");
  }

  const keywords = keywordToClLabel();

  let foundCl = false;
  for (let line of body.split("\n")) {
    if (line.startsWith(":cl:")) {
      foundCl = true;
      continue;
    } else if (line.startsWith("/:cl:")) {
      break;
    } else if (!foundCl) {
      continue;
    }
    // see if the first segment of the line is one of the keywords
    const foundLabel = keywords[line.split(":")[0]?.toLowerCase()];
    if (foundLabel) {
      // don't add a billion tags if they forgot to clear all the default ones
      const lineText = line.split(":")[1].trim();
      const clLabel = autoLabelConfig.changelog_labels[foundLabel];
      if (
        lineText !== clLabel.default_text &&
        lineText !== clLabel.alt_default_text
      ) {
        labelsToAdd.push(foundLabel);
      }
    }
  }
  return labelsToAdd;
}

// Checks the title for labels to add
function checkTitleForLabels(title) {
  const labelsToAdd = [];
  const titleLower = title.toLowerCase();
  for (let label in autoLabelConfig.title_labels) {
    let found = false;
    for (let keyword of autoLabelConfig.title_labels[label].keywords) {
      if (titleLower.includes(keyword)) {
        found = true;
        break;
      }
    }
    if (found) {
      labelsToAdd.push(label);
    }
  }
  return labelsToAdd;
}

// Checks the file diff for labels to add or remove
async function checkDiffForLabels(github, context, pullRequest) {
  const labelsToAdd = [];
  const labelsToRemove = [];

  try {
    const response = await github.rest.pulls.get({
      owner: context.repo.owner,
      repo: context.repo.repo,
      pull_number: pullRequest.number,
      headers: {
        Accept: "application/vnd.github.v3.diff",
      },
    });

    if (response.status === 200) {
      const diffTxt = response.data;
      for (let label in autoLabelConfig.file_labels) {
        let found = false;
        const { filepaths, add_only } = autoLabelConfig.file_labels[label];
        for (let filepath of filepaths) {
          if (diffTxt.includes(filepath)) {
            found = true;
            break;
          }
        }
        if (found) {
          labelsToAdd.push(label);
        } else if (!add_only) {
          labelsToRemove.push(label);
        }
      }
    } else {
      console.error(
        `Failed to fetch diff: ${response.status} ${response.statusText}`
      );
    }
  } catch (e) {
    console.error(e);
  }

  return { labelsToAdd, labelsToRemove };
}

// Main function to get the updated label set
export async function getUpdatedLabelSet({ github, context }) {
  const { action, pull_request } = context.payload;
  const {
    body = "",
    diff_url,
    labels = [],
    mergeable,
    title = "",
  } = pull_request;

  let updatedLabels = new Set();
  for (let label of labels) {
    updatedLabels.add(label.name);
  }

  // diff is always checked
  if (diff_url) {
    const diffTags = await checkDiffForLabels(github, context, pull_request);
    for (let label of diffTags.labelsToAdd) {
      updatedLabels.add(label);
    }
    for (let label of diffTags.labelsToRemove) {
      updatedLabels.delete(label);
    }
  }

  // body and title are only checked on open, not on sync
  if (action === "opened") {
    if (title) {
      for (let label of checkTitleForLabels(title)) {
        updatedLabels.add(label);
      }
    }
    if (body) {
      for (let label of checkBodyForLabels(body)) {
        updatedLabels.add(label);
      }
    }
  }

  // this is always removed on updates
  updatedLabels.delete("Test Merge Candidate");

  // update merge conflict label
  let mergeConflict = mergeable === false;
  // null means it was not reported yet
  // it is not normally included in the payload - a "get" is needed
  if (mergeable === null) {
    try {
      let response = await github.rest.pulls.get({
        owner: context.repo.owner,
        repo: context.repo.repo,
        pull_number: pull_request.number,
        headers: {
          Accept: "application/vnd.github.v3.diff",
        },
      });
      // failed to find? still processing? try again in a few seconds
      if (response.data.mergeable === null) {
        console.log("Awaiting GitHub response for merge status...");
        await new Promise((r) => setTimeout(r, 10000));
        response = await github.rest.pulls.get({
          owner: context.repo.owner,
          repo: context.repo.repo,
          pull_number: pull_request.number,
          headers: {
            Accept: "application/vnd.github.v3.diff",
          },
        });
        if (response.data.mergeable === null) {
          throw new Error("Merge status not available");
        }
      }

      mergeConflict = response.data.mergeable === false;
    } catch (e) {
      console.error(e);
    }
  }
  if (mergeConflict) {
    updatedLabels.add("Merge Conflict");
  } else {
    updatedLabels.delete("Merge Conflict");
  }

  // return the labels to the action, which will apply it
  return [...updatedLabels];
}
