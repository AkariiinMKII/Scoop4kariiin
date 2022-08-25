Import-Module $S4UtilsPath
Remove-ProfileContent $Content
Add-ProfileContent $Content
Remove-Module -Name S4Utils
