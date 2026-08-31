export FILTER_BRANCH_SQUELCH_WARNING=1
git filter-branch -f --env-filter '
export GIT_COMMITTER_NAME="Ayush Bansal"
export GIT_COMMITTER_EMAIL="ayush.ahws@gmail.com"
export GIT_AUTHOR_NAME="Ayush Bansal"
export GIT_AUTHOR_EMAIL="ayush.ahws@gmail.com"
' --tag-name-filter cat -- --all
