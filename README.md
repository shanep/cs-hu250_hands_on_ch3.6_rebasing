# Ch3.6
# Exercise: Rebasing - "Rewriting" the History

## Step 1
Familiarize yourself with the repository by checking the repository history, file structure, file contents, etc.

## Step 2
Read and understand the contents of the `./chaos_monkey.sh` script which will create an intricate repository structure with different branches, but without creating any merge commits.

Each branch will make changes in a separate file, thus avoiding any merge conflicts during future rebasing/merging operations.

The diagram below illustrates the conceptual structure of the repository and emphasizes the chronological order in which the commits were added to the multiple branches.
NOTE: The structure of this repository is a simplified version (e.g., it does not contain merge commits and has fewer branches) of the repository from the assignment `ch3.3_branch_management`.
```
                                                                                                    (branch6)
                                                                                                        |
             (branch1)                                          (branch4)                  /---------- C18 --------
                 |                                                  |                     /
        /------- C3 ----                     /-------------------- C12 ----------------- C16 -- C17 ---------------
       /                                    /
C0 -- C1 -- C2 --------------------------- C8 -------------- C11 ------------------------------------------- C19 --  //master
             \
              \----- C4 ------ C6 ------------- C9 ------------------- C13
                     |          \                                          \
                 (branch2)       \-- C7 -------------                       \ ---- C15 ----------------------------
                                     |                                              |
                                 (branch3)                                      (branch5)
```

## Step 3
Run the `./chaos_monkey.sh` script.

## Step 4
Run the following command to view the branch and commit history of the repository, where the current checked out branch is `master`:
```bash
$ git log --oneline --decorate --graph --all
```
Compare the output with the diagram from `Step 2`.

To focus only on a subset of branches, run:
```bash
$ git log --oneline --decorate --graph branch1 branch4 branch6
$ git log --oneline --decorate --graph branch2 branch3 branch5
```
Compare the output with the diagram from `Step 2`.

## Step 5
Rebase `branch3` on top of `branch2`.

First, checkout the branch that is going to be rebased.
```bash
$ git checkout branch3
```

Second, "zoom" into the two branches to understand better their relationship and interaction.
```bash
$ git log --oneline --decorate --graph branch3 branch2
```

Third, run the following command to conclude the rebasing.
```bash
$ git rebase branch2
```

Next, analyze the result of the rebasing operation.
```bash
$ git log --oneline --decorate --graph branch3 branch2
$ git log --oneline --decorate --graph --all
```

Finally, the `branch2` can be safely deleted because it is already integrated into `branch3`:
```bash
$ git branch --merged branch3
$ git branch -d branch2
```

## Step 6
Rebase `branch5` on top of `branch3`, using:
```bash
$ git checkout branch5
$ git log --oneline --decorate --graph branch5 branch3
$ git rebase branch3
$ git log --oneline --decorate --graph branch5 branch3
$ git log --oneline --decorate --graph --all
$ git branch --merged branch5
$ git branch -d branch3
```

## Step 7
Rebase `branch6` on top of `branch4`, using:
```bash
$ git checkout branch6
$ git log --oneline --decorate --graph branch6 branch4
$ git rebase branch4
$ git log --oneline --decorate --graph branch6 branch4
$ git log --oneline --decorate --graph --all
$ git branch --merged branch6
$ git branch -d branch4
```

## Step 8
Rebase `branch6` on top of `master`, using:
```bash
$ git checkout branch6
$ git log --oneline --decorate --graph branch6 master
$ git rebase master
$ git log --oneline --decorate --graph branch6 master
$ git log --oneline --decorate --graph --all
```

After these operations, `branch6` is "ahead" of `master` by four commits. To integrate the changes from `branch6` back into `master` use the `merge` command:
NOTE: The merge will be a "fast forward" merge since:
* `master` did not diverge from `branch6` and
* `branch6` had its commits "(re)based" on `master` (which was the result of the previous rebasing).
```bash
$ git checkout master
$ git merge branch6
$ git log --oneline --decorate --graph --all
$ git branch --merged master
$ git branch -d branch6
```

## Step 9
Rebase `branch1` on top of `master`, then ("fast forward") merge the changes from `branch1` back into `master`:
```bash
$ git checkout branch1
$ git log --oneline --decorate --graph branch1 master
$ git rebase master
$ git log --oneline --decorate --graph branch1 master
$ git checkout master
$ git merge branch1
$ git log --oneline --decorate --graph --all
$ git branch --merged master
$ git branch -d branch1
```

## Step 10
Finally, rebase `branch5` on top of `master`, then ("fast forward") merge the changes from `branch5` back into `master`.

## Step 11
Run the following command:
```bash
$ git log --oneline --decorate --graph --all
```

It is important to highlight that after these rebasing and "fast forward" merging operations, the `master` branch incorporated the changes from all branches while maintaining a linear history that is not cluttered with merge commits, making it easier for future developers to maintain the software contained in the repository.
