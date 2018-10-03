# shell_script
shell_commands


#How to upload a file on git repo......

1)Make a new repo in your git at gitgub web
2)git clone git@github.com:soarnsoar/[NEW_REPO]
3)git add [FileName]
OR
git add -A

4) git commit -m "MEMO"

(commit : save the files on your local)

5)git push [remote_repo] [branch_name]

e.g)git push -u origin master

push : upload "committed files" to remote(online) repository!

6)DONE



7)If you want to make a new branch
7-1) 
git branch [NEW_BRANCH_NAME]
->Then new branch is created

git branch -vv 
->you can see which branch you are using
7-2)
git checkout [NEW_BRANCH_NAME]
->move to the new branch
7-3)
git add [NEW_FILE]
git commit -m "add new file to new branch"

git push origin [NEW_BRANCH_NAME]


DONE