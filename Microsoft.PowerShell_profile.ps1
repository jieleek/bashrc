# ~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Key Escape,Ctrl+p -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key Tab -Function Complete
