param (
    [switch] $p = $false
)

if ($p) {
    $push = !$defaultPush
} else {
    $push = $defaultPush
}

git add -A
git commit --amend --no-edit -C HEAD
if ($push) {
    git push --force
}
