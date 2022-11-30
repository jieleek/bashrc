# ~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Key Escape,Ctrl+p -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key Tab -Function Complete
# After install z.lua
# Invoke-Expression (& { (lua C:\Users\jie.li\scoop\apps\z.lua\current\z.lua --init powershell enhanced once) -join "`n" })
Remove-Item Alias:curl
Remove-Item Alias:ls
Remove-Item Alias:cp
Remove-Item Alias:diff -Force
Remove-Item Alias:sort -Force
Remove-Item Alias:tee -Force
Remove-Item Alias:wget
Remove-Item Alias:cat
Remove-Item Alias:mv
Remove-Item Alias:rm
Remove-Item Alias:echo
Remove-Item Alias:foreach -Force
Remove-Item Alias:man
Remove-Item Alias:mount
Remove-Item Alias:ps
Remove-Item Alias:pushd
Remove-Item Alias:pwd
Remove-Item Alias:set
Remove-Item Alias:start -Force
Remove-Item Alias:where -Force
function Write-BranchName () {
    try {
        $branch = git rev-parse --abbrev-ref HEAD

        if ($branch -eq "HEAD") {
            # we're probably in detached HEAD state, so print the SHA
            $branch = git rev-parse --short HEAD
            Write-Host " ($branch)" -ForegroundColor "red"
        }
        else {
            # we're on an actual branch, so print it
            Write-Host " ($branch)" -ForegroundColor "yellow"
        }
    } catch {
        # we'll end up here if we're in a newly initiated git repo
        Write-Host " (no branches yet)" -ForegroundColor "yellow"
    }
}

function prompt {
    $base = "PS "
    $path = "$($executionContext.SessionState.Path.CurrentLocation)"
    $userPrompt = "$('$' * ($nestedPromptLevel + 1)) "

    Write-Host "`n$base" -NoNewline

    if (Test-Path .git) {
        Write-Host $path -NoNewline
        Write-BranchName
    }
    else {
        # we're not in a repo so don't bother displaying branch name/sha
        Write-Host $path
    }

    return $userPrompt
}
function prompt1 {
    $base = "PS "
    $path = "$($executionContext.SessionState.Path.CurrentLocation)"
    $userPrompt = "$('>' * ($nestedPromptLevel + 1)) "

    Write-Host "`n$base" -NoNewline

    if (Test-Path .git) {
        Write-Host $path -NoNewline -ForegroundColor "green"
        Write-BranchName
    }
    else {
        # we're not in a repo so don't bother displaying branch name/sha
        Write-Host $path -ForegroundColor "green"
    }

    return $userPrompt
}
function prompt2 { "PS $(Get-Location)`r`n$ " }

# git prompt
# Import-Module posh-git
# Add-PoshGitToProfile -AllHost
# oh-my-posh init pwsh | Invoke-Expression
# oh-my-posh init pwsh --config 'aliens\jandedobbeleer.omp.json' | Invoke-Expression
