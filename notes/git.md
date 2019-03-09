Git
===
Various usefull snippets and practices for working with ``git``.


Change Repository Author
------------------------
Change author on a per-repository basis will put user to repository conf. Needs
to **BE DONE AFTER EVERY NEW CLONE**.

    $ git config user.name "John Doe"
    $ git config user.email "john@doe.org"


Keeping Fork Up-to-Date With Upstream
-------------------------------------
Common practice is to add `upstream` remote and fetch from there.

    $ cd fork
    $ git remote add upstream git://UPSTREAM
    $ git fetch upstream
    $ git checkout master
    $ git pull upstream master
    $ git push


Rebasing
--------
Rebase will take all commits on the branch and move them above HEAD of branch
rebased to.

    $ git co FEATURE-BRANCH
    $ git rebase origin/master
