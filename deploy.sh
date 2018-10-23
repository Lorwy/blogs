#hugo --theme=Jane -buildDrafts --baseUrl="htt://lorwy.github.io/"

#!/bin/bash
if [ $# -lt  1 ]; then
    echo "$0 <commit message>"
    exit 1
fi
msg="$1"
git commit -m "$msg"

git push origin master



echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"
# Build the project.
#hugo # if using a theme, replace with `hugo -t <YOURTHEME>`
hugo --theme=Jane -buildDrafts --baseUrl="htt://lorwy.github.io/"
# Go To Public folder
cd public
# Add changes to git.
git add .
# Commit changes.
git commit -m "$msg"
# Push source and build repos.
git push origin master
# Come Back up to the Project Root
cd ..

