Import-Module $ModifyPSProfile
RemovefromProfile 'Import-Module Windows-screenFetch'
AppendtoProfile 'Import-Module Windows-screenFetch'
Remove-Module -Name ModifyPSProfile
