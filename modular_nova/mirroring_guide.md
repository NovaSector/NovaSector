# Welcome to the guide on how to manually do batch mirrors for the repo

This guide will help you in pulling Pull requests from TG and adding them into a PR to be merged here in Nova. This guide will teach you two methods of doing such, one slow and one faster one though both do the Job in the end one requires additional software as it helps make the process faster and easier to acomplish.

## *DO NOTE ALL OF THIS SHOULD BE DONE ON A FORK OF NOVA's REPO, IF YOU DIRECTLY CLONED THE REPO YOU WILL NOT BE ABLE TO DO THIS*

## Software

[Git-Scm](https://git-scm.com/) - This is required to basically do anything Git related, as this is git commandline and can do practically anything. It does come with a rather basic barebones GUI but I will not be covering that in here.

[Git-Fork](https://git-fork.com/) - A really good GUI client, will be used is the second part of the tutorial for the faster method of doing the mirroring, It has a useful GUI, the only downside is it costs money, which is a one time payment fee, whereas the commandline is free jsut slower.

### *Optionally*

[Github Desktop](https://desktop.github.com/download/) - Decent GUI client, though doesn't handle doing cherry picking from across different repos very easily. It is much better at doing branch managment and also testing out Pull Requests.

## Command line Guide

This portion will cover command line commands you need to execute, relativly simple and easy but takes some time and copy pasting hashs. You need to add TG as a remote for tracking so git knows where to pull the PR's from as well as being able to fetch all the changed pushed to their repo.

First Command to run
`git remote add tgstation https://github.com/tgstation/tgstation`

This will ad TG's repo under the name of tgstation, that way its changes will be tracked when it gets fetched and can be cherry picked. From here we need to fetch the repo.

`git fetch tgstation`

This as stated above will fetch TG, it wont download the whole repo, but it will add tracking for all the hashs for PR's and all changes.
From here Simply go to any merged TG PR and you need to grab two hashs to do two different cherry picks.

Using this Pull Request as an [Example](https://github.com/tgstation/tgstation/pull/85448)

You would want to scroll down to the bottom of the page and look for the merge commit. It would look like this:

![Screenshot](http://files.byondhome.com/SomeRandomOwl/firefox_mkROS7ApgD.png)

Simply click on the random string of letters/numbers, and in the url address bar copy the large random string thats just after /commit/
In this example it should look like this. `281dac4ed0e2976cdecb4777c93a19bc9b787db4`

Then look for the Automatic Changelog for the PR as pictured below.

![Screenshot](http://files.byondhome.com/SomeRandomOwl/firefox_OfwBeopgiw.png)

On that you can click on the words automatic changelog or the random hash at the far right, both works.
In this example the hash for the changelog is this. `66bc14224557ad041d4a146cf1bb079994740787`

Once you have both of those hashs copied down somewhere it is back to doing git commands.

* Make a new branch on your fork with the command `git switch -c [Insert name of branch here]`
* Publish the branch to your fork with this command `git push origin [The name of the branch]`

This will make a new branch and ensure you are editing it now to add the PR in do the following

* The PR itself `git cherry-pick 281dac4ed0e2976cdecb4777c93a19bc9b787db4`
* The PR changelog `git cherry-pick 66bc14224557ad041d4a146cf1bb079994740787`

This will pull the pr and changelog into your branch from there you can either add more PR's into it or fix conflicts and errors.

When you are finished, you can Either visit github and open your fork on the website and go through the process of making a Pull Request, or use the github desktop app which has a button to take you directly to making a Pull request.

### This guide wont really cover making the Pull request itself as theres already a guide for that, this simply covers pulling the changes from TG into a PR

## GUI Guide using Git-Fork

This next portion of the guide is basically the above but using Git-Fork which helps immensly speed up the process of pulling multiple PR's into a new Pull Request for Nova.

Open up Git-fork, and using open up the directory containing your cloned fork (or clone your fork if you dont have it already cloned)

On the left side panel there should be a list that has all of the repo's remotes, right click on it and click on add new remote.
From there, name the remote as you want I.E. 'tgstation' and for the repository URL put `https://github.com/tgstation/tgstation`

![Screenshot](http://files.byondhome.com/SomeRandomOwl/Fork_oqKYvSerNP.png)
![Screenshot2](http://files.byondhome.com/SomeRandomOwl/Fork_F2LtlwBlFA.png)

From there just click on add new remote.

Now to to make the PR pulling changes from TG.
Create a nw branch using either the Repository dropdown on the title bar -> New Branch. Or use the hotkey `Ctrl+shift+b` and name the branch whatever you want.

From here it is super simple to add in the the Pull requests from TG you wish to add to your pull request to merge into Nova.
On the side panel where it lists remotes, click on the button with the tooltip `show branches from here only`

![Screenshot](http://files.byondhome.com/SomeRandomOwl/Fork_8L4ULsFpcP.png)

And then from the main view, simply hold Ctrl and click on the PR + its changelog for each and every Pull Request you wish to copy over to Nova. Then right click on oneand then click on Cherry Pick and then click Cerrypick commits on the resulting dialog.

![Screenshot](http://files.byondhome.com/SomeRandomOwl/Fork_ElARfHdxH1.png)
![Screenshot2](http://files.byondhome.com/SomeRandomOwl/Fork_08HRCEw9cF.png)

Then from there, you can simple push changes and either fix any conflicts or errors, and then go to github to make a Pull Request to nova
