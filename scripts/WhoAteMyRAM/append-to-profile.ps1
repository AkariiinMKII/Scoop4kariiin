Import-Module $ModifyPSProfile
RemovefromProfile 'Import-Module WhoAteMyRAM'
AppendtoProfile 'Import-Module WhoAteMyRAM'
Remove-Module -Name ModifyPSProfile
