# ~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
# Windows PowerShell 5.1 may have PSReadLine without prediction support.
if ((Get-Command Set-PSReadLineOption).Parameters.ContainsKey('PredictionSource')) {
    Set-PSReadLineOption -PredictionSource History
}
Set-PSReadLineOption -EditMode Emacs -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Escape,p' -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key Tab -Function Complete
# After install z.lua
foreach ($filePath in @(
    'C:\Users\jiele\scoop\apps\z.lua\current\z.lua'
    'E:\Scoop\apps\z.lua\current\z.lua'
)) {
    if (Test-Path -LiteralPath $filePath) {
        Invoke-Expression ((& lua $filePath --init powershell enhanced once) -join "`n")
    }
}

# Prefer external tools; tolerate aliases already removed by a previous load.
foreach ($aliasName in @(
    'curl', 'ls', 'cp', 'gl', 'diff', 'sort', 'tee', 'wget', 'cat', 'mv',
    'rm', 'echo', 'foreach', 'man', 'mount', 'ps', 'pushd', 'pwd', 'set',
    'start', 'where'
)) {
    if (Test-Path -LiteralPath "Alias:$aliasName") {
        Remove-Item -LiteralPath "Alias:$aliasName" -Force
    }
}

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
function Get-PromptGitInfo {
    $previousExitCode = $global:LASTEXITCODE
    try {
        if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
            return
        }
        $branch = & git rev-parse --abbrev-ref HEAD 2>$null
        if ($LASTEXITCODE -ne 0) { return }

        $isDetached = $branch -eq 'HEAD'
        if ($isDetached) {
            $branch = & git rev-parse --short HEAD 2>$null
            if ($LASTEXITCODE -ne 0) { return }
        }

        [PSCustomObject]@{ Name = $branch; IsDetached = $isDetached }
    } catch {
        # Missing Git, an unborn branch, or a non-repository directory.
        return
    } finally {
        $global:LASTEXITCODE = $previousExitCode
    }
}

function Write-BranchName ($p1, $p2, $conda) {
    $gitInfo = Get-PromptGitInfo
    Write-Host "$p1$p2" -NoNewLine
    if ($gitInfo) {
        $branchColor = if ($gitInfo.IsDetached) { 'Red' } else { 'Yellow' }
        Write-Host " ($($gitInfo.Name))" -ForegroundColor $branchColor -NoNewLine
    }
    Write-Host " $conda" -ForegroundColor Green
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

function prompt {
    # Windows PowerShell 5.1 needs an explicit ESC character for ANSI colors.
    $esc = [char]27
    $dirColor = "$esc[38;5;190m"
    $gitBranchColor = "$esc[38;5;78m"
    $condaEnvColor = "$esc[38;5;177m"
    $resetColor = "$esc[0m"

    # Current path
    $currentPath = $ExecutionContext.SessionState.Path.CurrentLocation.Path

    # Assemble optional Git and Conda segments without duplicating layout.
    $gitInfo = Get-PromptGitInfo
    $segments = @()
    if ($gitInfo) {
        $segments += "$gitBranchColor$($gitInfo.Name)$resetColor"
    }
    if ($env:CONDA_DEFAULT_ENV) {
        $segments += "$condaEnvColor$env:CONDA_DEFAULT_ENV$resetColor"
    }

    $promptString = "`nPS ${dirColor}$currentPath${resetColor}"
    if ($segments.Count -gt 0) {
        $promptString += " ($($segments -join ' '))"
    }

    return "$promptString`n$ "
}

function prompt1 {
    $base = "PS "
    $path = "$($executionContext.SessionState.Path.CurrentLocation)"
    $userPrompt = "$('$' * ($nestedPromptLevel + 1)) "

    $conda = ''
    if ($env:CONDA_PROMPT_MODIFIER) {
        # trim the leading and trailing space
        $conda = $env:CONDA_PROMPT_MODIFIER.Trim()
        # remove the parenthesis of the conda env name
        $conda = $conda.Substring(1, $conda.Length - 2)
        $conda = "[$conda]"
    }
    Write-BranchName "`n$base" $path $conda

    return $userPrompt
}
function prompt2 { "PS $(Get-Location)`r`n$ " }

