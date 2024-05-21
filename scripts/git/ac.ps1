param (
    [switch] $p = $false
)

if ($p) {
    $push = !$defaultPush
} else {
    $push = $defaultPush
}

$commitMessage = $args[0]

if (!$commitMessage) {
    $commitMessage = Read-Host -Prompt 'Add Commit Message'
}

git add -A
git commit -m "$commitMessage"
if ($push) {
    git push
}

