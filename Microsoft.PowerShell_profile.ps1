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
