# Welcome to the guide on how to manually do batch mirrors for the repo

This guide will help you in pulling Pull requests from TG and adding them into a PR to be merged here in Nova.

## *DO NOTE ALL OF THIS SHOULD BE DONE ON A FORK OF NOVA's REPO, IF YOU DIRECTLY CLONED THE REPO YOU WILL NOT BE ABLE TO DO THIS*

## Required Software

[Git-Scm](https://git-scm.com/) - This is required to basically do anything Git related. Comes with a commandline that is capable of doing everything. If you would prefer to use a GUI, you will want to use Fork or a combination of commandline + Github Desktop (see below). Git does come with a rather basic barebones GUI out of the box but that will not be covered here.

### *(Optional)*

[Git-Fork](https://git-fork.com/) - A really good GUI client, will be used is the second part of the tutorial for the faster method of doing the mirroring, It has a useful GUI, the only downside is it costs money, which is a one time payment fee, whereas the commandline is free just slower.

[Github Desktop](https://desktop.github.com/download/) - Decent GUI client, though doesn't handle doing cherry picking from across different repos. You will need to use a combination of this and the commandline, but with practice it becomes nearly as fast as using Fork honestly. It is very helpful for visualizing branch managment and also testing out Pull Requests (making it easy to switch to their branches).

## Getting started

Start by opening the git bash and navigating to your repo directory.
* (use `cd name_of_folder` to navigate, you can use tab for autocomplete to make it go faster). When you arrive in the right place it should look something like this. ![image](https://github.com/user-attachments/assets/97532c25-fce0-43da-a451-32ce7195fa19) My current branch is 'Guide' so that's why it says '(Guide)'.

Once in there, add tgstation as a remote if you do not already have that done on your fork. Simply run the following command:

`git remote add tgstation https://github.com/tgstation/tgstation`

This will ad TG's repo as a remote under the name of tgstation. **You only need to do this step once.**

From here we need to [fetch](https://git-scm.com/docs/git-fetch) the repo to actually get the refs. Simply run the following command:

`git fetch tgstation`

This will simply grab an up to date set of refs that make up the history of the repo. It wont download the actual files, but it will update the history so you are able to cherry pick the most recent commits from TG. **You will generally want do do this every time you make a mirror.**

## Command-line

This portion will teach you how to do everything through the command-line, which for some people is the fastest and easiest way. If you prefer to use a GUI, [skip](#gui-guide-using-git-fork) to the next section.

### Create and checkout a branch

Now, before you do anything else, as always with opening any PR it is important that you open a new branch! The command below will create a new branch called 'manual-mirror-1' and swap to it automatically. The name is not important at all, you can call it whatever you want.

`git checkout -b manual-mirror-1`

### Publish this branch to your remote

While we are at it, let's take a moment to publish the branch so that it appears on your remote as well. Since as of now it's just a local branch, and you will need it to be on the remote in order to open a pull request. Simply run the following:

`git push -u origin HEAD`

### Finding the commit hash

Next up you need to find the hash(es) of the merge commit(s) of the PR(s) that you are trying to mirror. There are a few ways of doing this but here is a simple way that requires no additional software:

Using this Pull Request as an [Example](https://github.com/tgstation/tgstation/pull/85448)

You would want to scroll down to the bottom of the page and look for the merge commit. It would look like this:

![Screenshot](http://files.byondhome.com/SomeRandomOwl/firefox_mkROS7ApgD.png)

### Singular commit cherry pick

1) Simply click on the abbreviated hash link (the `281dac4` shown in the example above), and in the url address bar copy full version of the hash just after /commit/
In this example it should be `281dac4ed0e2976cdecb4777c93a19bc9b787db4`

2) To grab this singular commit, assuming the previous steps have been completed you would just need to run the following command:
`git cherry-pick -m 1 281dac4ed0e2976cdecb4777c93a19bc9b787db4`

**That is for a singular commit**. To do a range of commits, you need to find a second hash. Repeat step 1) to find a second commit (See below for example)

### Doing a range of commits as a cherry pick

For example, let's look for the Automatic Changelog commit from that same PR.
It is highly recommended to grab this because it will keep the author's name from TG instead of just putting yours in the changelog.
**If you are doing more than one PR at a time, you -must- include the Autochangelogs.**

![Screenshot](http://files.byondhome.com/SomeRandomOwl/firefox_OfwBeopgiw.png)

On that you can click on the words automatic changelog or the random hash at the far right, both works.
In this example the hash for the changelog is this. `66bc14224557ad041d4a146cf1bb079994740787`

Now that you have both the starting and ending commit hashes, simply run the following command to grab these commits and everything in between:

`git cherry-pick A^..B` where A is the start of the range, aka, in our case:

`git cherry-pick -m 1 281dac4ed0e2976cdecb4777c93a19bc9b787db4^..66bc14224557ad041d4a146cf1bb079994740787`

**NOTE: The *first* hash in the command -must- be the oldest commit, or else the command will just silently fail.**
The `^` is also important, omitting that will cause commit `A` to be not included itself. Which for our purposes you don't generally want.

### Pushing the changes to your remote

Once you have done this, if it goes through smoothly you will be done. Run the following command to push the changes to remote.

`git push`

### What if I don't want all the commits in the range?

This is where `git rebase` comes in. Let's say you have a few commits that you grabbed in a range, and you want to get rid of some that were in the middle. These might be Autochangelog compiles that we don't need, or whatever.

`git rebase -i HEAD~10`

Running this command will open the interactive rebase text file, which has a list of commits prefaced by `pick`
![notepad++_xuDB6Uymt4](https://github.com/user-attachments/assets/078d9f8e-df07-49fd-9e53-ae298f7f7804)

Any commits that you want to get rid of, simply replace `pick` with `drop`, then save + close the file. Those commits should now be gone!

From there do a force push to update your remote before opening your PR:

`git push -f`

### What if there are merge conflicts?

Oftentimes things will not go smoothly and there will be a merge conflict. In those cases you'll need to resolve them manually.

There are many online guides for this, [such as this one](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/addressing-merge-conflicts/resolving-a-merge-conflict-on-github), but a tip if you use VSC: one of the easiest ways to find the conflicts is to just do a search for `<<<` (the merge conflict marker). The exception here is if it's a conflict of a missing file or modified .dmi which will require you to choose which version of the file to keep. When this happens and you are unsure how to proceed you can just grab a the version of the file from TG and copy paste it in.

### Opening the pull request

Now you are ready to open your [pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request)! You can either visit github and open your fork on the website and go through the process of making a Pull Request, or use the github desktop app which has a button to take you directly to making a Pull request. Fork also has this option in the left hand pane if you right click NovaSector master branch.

If you have included the Autochangelogs from TG (highly recommended), please do not include a changelog in the PR body.

Otherwise, if it is a singular mirror please link the original TG PR in the body of the pull request. If it is a batch you do not have to bother with this.
Again, **If you include Autochangelog commits please do not include a changelog as this will result in doubled up changelog entries.**

## GUI Guide using Git-Fork

This next portion of the guide is basically the above but using Git-Fork which helps the process of pulling multiple PR's into a new Pull Request for Nova.
It basically provides a visualization for the list of commits in order and lets you select them via shift/ctrl click rather than having to find commit hashes and rebases.
It is as such faster once you get the hang of it, so this is a recommended way of doing it if you plan on doing it often. It is absolutely not necessary though!

Open up Git-fork, and using open up the directory containing your cloned fork (or clone your fork if you dont have it already cloned)

On the left side panel there should be a list that has all of the repo's remotes, right click on it and click on add new remote.
From there, name the remote as you want I.E. 'tgstation' and for the repository URL put `https://github.com/tgstation/tgstation`

![Screenshot](http://files.byondhome.com/SomeRandomOwl/Fork_oqKYvSerNP.png)
![Screenshot2](http://files.byondhome.com/SomeRandomOwl/Fork_F2LtlwBlFA.png)

From there just click on add new remote.

Now to to make the PR pulling changes from TG.
Create a new branch using either the Repository dropdown on the title bar -> New Branch. Or use the hotkey `Ctrl+shift+b` and name the branch whatever you want.

From here it is super simple to add in the the Pull requests from TG you wish to add to your pull request to merge into Nova.
On the side panel where it lists remotes, click on the filter button with the tooltip `show branches from here only`
**It is recommended to pin the tgstation master branch to the left panel so you can easily click the filter button (to the right of the pin button) when you need to. Clear branch filter is Ctrl+Shift+A, use this to quickly swap between tg's commits and your own branches**
![image](https://github.com/user-attachments/assets/233baa7e-7615-4c5e-ba45-0c59e5045654)


![Screenshot](http://files.byondhome.com/SomeRandomOwl/Fork_8L4ULsFpcP.png)

And then from the main view, simply hold Ctrl and click on the PR + its changelog for each and every Pull Request you wish to copy over to Nova. Right click on one and then click on 'Cherry-pick...' and then click 'Cherry Pick `n` commits' on the resulting dialog.

![Screenshot](http://files.byondhome.com/SomeRandomOwl/Fork_ElARfHdxH1.png)
![Screenshot2](http://files.byondhome.com/SomeRandomOwl/Fork_08HRCEw9cF.png)

Then from there, you can simply push changes and either fix any conflicts or errors, and then use Fork, Github Desktop, or go to github to make your Pull Request to NovaSector.

On your downstream repo if you are merging a Mirror/batch Pull Request that contains multiple commits it is recommended to use the "Create a Merge Commit", aka "Merge Pull Request" option instead of "Squash and Merge", to preserve the commit history.

![418799841-a0ede384-d3d9-462f-a41f-4108734bb894](https://github.com/user-attachments/assets/0f4786d6-ba17-4529-87e0-d8ca87dee321)

![418800033-39a658d0-d85b-454b-945d-8e77d6b032a9](https://github.com/user-attachments/assets/bef06860-1c7b-4057-affa-99f37b5e0630)

(Note: the "Rebase and Merge" option may also be used, at your own preference. Both will keep the commit history intact but have their own advantages/disadvantages. We exclusively use Merge commits here on Nova).
