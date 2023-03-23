# ~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
Set-PSReadlineOption -PredictionSource History
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Chord 'Escape,p' -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadlineOption -BellStyle None
Invoke-Expression (& { (lua C:\Users\jie.li\scoop\apps\z.lua\current\z.lua --init powershell enhanced once) -join "`n" })
# Remove-Item Alias:curl
Remove-Item Alias:ls
Remove-Item Alias:cp
Remove-Item Alias:gl -Force
Remove-Item Alias:diff -Force
Remove-Item Alias:sort -Force
Remove-Item Alias:tee -Force
# Remove-Item Alias:wget
Remove-Item Alias:cat
Remove-Item Alias:mv
Remove-Item Alias:rm
Remove-Item Alias:echo

#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
If (Test-Path "C:\Users\jie.li\scoop\apps\miniconda3\current\Scripts\conda.exe") {
    (& "C:\Users\jie.li\scoop\apps\miniconda3\current\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | ?{$_} | Invoke-Expression
}
#endregion

function Invoke-LsColor {
    & 'ls.exe' --color $args
}

New-Alias -Name ls -Value Invoke-LsColor

function gl() {
	& git log --oneline --all --graph --decorate
}
function Write-BranchName ($p1, $p2, $conda) {


    try {
        $branch = git rev-parse --abbrev-ref HEAD

        if ($branch -eq "HEAD") {
            # we're probably in detached HEAD state, so print the SHA
            $branch = git rev-parse --short HEAD
            Write-Host "$p1$p2" -NoNewLine
            Write-Host " ($branch)" -ForegroundColor "red" -NoNewLine
            Write-Host " $conda" -ForegroundColor "green"
        }
        else {
            if ($branch) {
            # we're on an actual branch, so print it

				Write-Host "$p1$p2" -NoNewLine
                Write-Host " ($branch)" -ForegroundColor "yellow" -NoNewLine
                Write-Host " $conda" -ForegroundColor "green"
            } else {
                Write-Host "$p1$p2" -NoNewLine
                Write-Host " $conda" -ForegroundColor "green"
            }
        }
    } catch {
        # we'll end up here if we're in a newly initiated git repo
        # Write-Host " (no branches yet)" -ForegroundColor "yellow"
        Write-Host "$p1$p2" -NoNewLine
        Write-Host " $conda" -ForegroundColor "green"
    }
}

function prompt {
    $base = "PS "
    $path = "$($executionContext.SessionState.Path.CurrentLocation)"
    $userPrompt = "$('$' * ($nestedPromptLevel + 1)) "

    # Write-Host "`n$base" -NoNewline
    # Write-Host $path -NoNewline

    if ($env:CONDA_PROMPT_MODIFIER) {
        # trim the leading and trailing space
        $conda = $env:CONDA_PROMPT_MODIFIER.Trim()
        # remove the parenthesis of the conda env name
        $conda = $conda.Substring(1, $conda.Length - 2)
        Write-BranchName "`n$base" $path "[$conda]"
    } else {
        Write-BranchName "`n$base" $path ""
    }

    return $userPrompt
}
function prompt2 { "PS $(Get-Location)`r`n$ " }

