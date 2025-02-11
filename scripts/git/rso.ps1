param (
    [switch] $stage = $false,
    [switch] $p = $false
)

if ($p) {
    $push = !$defaultPush
} else {
    $push = $defaultPush
}

$branchName = $args[0]
$commitMessage = $args[1]
$status = git status

if ($status -like "*nothing to commit*") {
} else {
    Write-Error 'Not working on a clean branch'
    exit
}

if ($branchName -eq $null) {
    Write-Warning 'You need a branch name as first argument'
    exit
}

if ($commitMessage -eq $null) {
    $commitMessage = Read-Host -Prompt 'Commit message?' 
}

if ([string]::IsNullOrEmpty($commitMessage)) {
    Write-Warning 'Actually you need a commit message'
    exit
}

Write-Warning "Have you already merged $branchName (Y or N)"

$keyOption = 'Y','N'
while ($keyOption -notcontains $keyPress.Character) {
    $keyPress = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

switch ($keyPress.Character) {
    Y { $canSquash = $true }
    N { $canSquash = $false }
    Default { $canSquash = $false }
}

if ($canSquash) {
    Write-Warning "Squashing Branch!! & Pushing forcefully"
    git reset --soft origin/$branchName

    if(!$stage) {
        git commit -m $commitMessage
        if ($push) { 
            git push -f
        }
    } else {
        Write-Output $commitMessage
    }
} else {
    Write-Warning "Did NOT squash your branch"
}
