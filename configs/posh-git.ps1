
if (Test-Path $poshPath) {
    Import-Module $poshPath

    $GitPromptSettings.DefaultPromptWriteStatusFirst = $true
    $GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $false
    $GitPromptSettings.PathStatusSeparator = '`n'
    $GitPromptSettings.IndexColor.ForegroundColor = [ConsoleColor]::Green
    $GitPromptSettings.BeforeIndex.ForegroundColor = [ConsoleColor]::Green
    $GitPromptSettings.WorkingColor.ForegroundColor = [ConsoleColor]::Magenta
    $GitPromptSettings.LocalWorkingStatusSymbol.ForegroundColor = [ConsoleColor]::Red

    function prompt { return & $GitPromptScriptBlock }
}

