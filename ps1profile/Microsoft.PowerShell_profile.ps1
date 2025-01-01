# ~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
Set-PSReadlineOption -PredictionSource History
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Chord 'Escape,p' -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadlineOption -BellStyle None
# After install z.lua
$filePath = "C:\Users\jiele\scoop\apps\z.lua\current\z.lua"
if (Test-Path -Path $filePath) {
    Invoke-Expression (& { (lua $filePath --init powershell enhanced once) -join "`n" })
}
$filePath = "E:\Scoop\apps\z.lua\current\z.lua"
if (Test-Path -Path $filePath) {
    Invoke-Expression (& { (lua $filePath --init powershell enhanced once) -join "`n" })
}
Remove-Item Alias:curl
Remove-Item Alias:ls
Remove-Item Alias:cp
Remove-Item Alias:gl -Force
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

# used for light color theme
Set-PSReadLineOption -Colors @{
  Command            = 'Magenta'
  Number             = 'DarkBlue'
  Member             = 'DarkBlue'
  Operator           = 'DarkBlue'
  Type               = 'DarkBlue'
  Variable           = 'DarkGreen'
  Parameter          = 'DarkGreen'
  ContinuationPrompt = 'DarkBlue'
  Default            = 'DarkBlue'
}

#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
If (Test-Path "E:\scoop\apps\miniconda3\current\Scripts\conda.exe") {
    (& "E:\scoop\apps\miniconda3\current\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | ?{$_} | Invoke-Expression
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

function Switch-JDKVersion {
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [int]$VersionNumber
    )

    $User = 'noname' # Replace with your username or pass as a parameter
    $JDKPath = "C:\Users\$User\scoop\apps\temurin${VersionNumber}-jdk\current"

    if(Test-Path $JDKPath) {
        # Set JAVA_HOME to the specified JDK path
        $env:JAVA_HOME = $JDKPath

        # Prepend the JDK's bin directory to the Path environment variable
        $env:Path = "$env:JAVA_HOME\bin;$env:Path"

        Write-Host "JDK switched to version $VersionNumber."
    } else {
        Write-Host "The specified JDK version $VersionNumber does not exist at $JDKPath"
    }
}

# For Windows PowerShell 5.1, ansi color can be implemented as
# $Esc=[char]0x1b
# $dirColor = "$Esc[38;5;3m"
# $resetColor = "$Esc[0m"
function prompt {
    # Define colors
    $dirColor = "`e[38;5;190m"
    $gitBranchColor = "`e[38;5;78m"
    $condaEnvColor = "`e[38;5;177m"
    $resetColor = "`e[0m"

    # Current path
    $currentPath = $ExecutionContext.SessionState.Path.CurrentLocation.Path

    # Git branch
    $gitBranch = ''
    if (Get-Command git -ErrorAction SilentlyContinue) {
        try {
            $gitBranch = & git rev-parse --abbrev-ref HEAD
        } catch {
            $gitBranch = ''
        }
    }
    if ($gitBranch -eq "HEAD") {
            # we're probably in detached HEAD state, so print the SHA
            $gitBranch = git rev-parse --short HEAD
    }    

    # Conda environment
    $condaEnv = $env:CONDA_DEFAULT_ENV
    if (-not $condaEnv) {
        $condaEnv = ''
    }

    # Construct the prompt
    $promptString = "`nPS ${dirColor}$currentPath${resetColor}"
    if ($gitBranch -and $condaEnv) {
        $promptString += " (${gitBranchColor}$gitBranch${resetColor} ${condaEnvColor}$condaEnv${resetColor})"
    } elseif ($gitBranch) {
		$promptString += " (${gitBranchColor}$gitBranch${resetColor})"
    } elseif ($condaEnv) {
		$promptString += " (${condaEnvColor}$condaEnv${resetColor})"
    }

    return "$promptString`n$ "
}

function prompt1 {
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

