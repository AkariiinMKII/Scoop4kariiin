#Requires -Version 5.0

function New-ProfileModifier {
    <#
    .SYNOPSIS
        Generate scripts from template.

    .PARAMETER Type
        Type of manifest, support module in current version.

    .PARAMETER Name
        Name of manifest.

    .PARAMETER BucketDir
        Path of bucket root directory.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string] $Type,
        [Parameter(Mandatory = $true, Position = 0)]
        [string] $Name,
        [Parameter(Mandatory = $true, Position = 0)]
        [string] $BucketDir
    )

    $SupportedType = @("module")

    if ($SupportedType -notcontains $Type) {
        Write-Host "Error: Unsupported type." -ForegroundColor Red
        Return
    }

    $ScoopDir = Split-Path (Split-Path $BucketDir)
    $AppDir = Join-Path -Path $ScoopDir -ChildPath "\apps\$Name\current\"
    $Scoop4kariiinUtilsPath = Join-Path -Path $BucketDir -ChildPath "\scripts\Scoop4kariiinUtils.psm1"

    switch ($Type) {
        {$_ -eq "module"} {
            $TempletPathAdd = Join-Path -Path $BucketDir -ChildPath "\scripts\modify-profile-template\add-profile-content.ps1"
            $TempletPathRemove = Join-Path -Path $BucketDir -ChildPath "\scripts\modify-profile-template\remove-profile-content.ps1"
            if (-not((Test-Path $TempletPathAdd) -and (Test-Path $TempletPathRemove))) {
                Write-Host 'Missing files, please update scoop buckets and reinstall the manifest.' -ForegroundColor Red
                Return
            }
            $ProfileContent = ("'", "Import-Module ", $Name, "'") -Join("")
            $AddProfileContent = Get-Content -Path $TempletPathAdd
            $AddProfileContent = $AddProfileContent.Replace('$Scoop4kariiinUtilsPath',$Scoop4kariiinUtilsPath)
            $AddProfileContent = $AddProfileContent.Replace('$ProfileContent',$ProfileContent)
            $AddProfileContent | Set-Content -Path "$AppDir\add-profile-content.ps1" -Encoding utf8
            $RemoveProfileContent = Get-Content -Path $TempletPathRemove
            $RemoveProfileContent = $RemoveProfileContent.Replace('$Scoop4kariiinUtilsPath',$Scoop4kariiinUtilsPath)
            $RemoveProfileContent = $RemoveProfileContent.Replace('$ProfileContent',$ProfileContent)
            $RemoveProfileContent | Set-Content -Path "$AppDir\remove-profile-content.ps1" -Encoding utf8
        }
    }
}

function Add-ProfileContent {
    <#
    .SYNOPSIS
        Add certain content to PSProfile.

    .PARAMETER Content
        Content to be added.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string] $Content
    )

    if (!(test-path $profile)) {
        New-Item -Path $profile -Value "$content" -ItemType File -Force | Out-Null
    }
    else {
        Add-Content -Path $profile -Value "`n$content" -NoNewLine
    }
}

function Remove-ProfileContent {
    <#
    .SYNOPSIS
        Remove certain content from PSProfile.

    .PARAMETER Content
        Content to be removed.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string] $Content
    )

    ((Get-Content -Path $profile -raw) -replace "[\r\n]*$content",'').trim() | Set-Content $profile -NoNewLine
}

function Mount-ExternalRuntimeData {
    <#
    .SYNOPSIS
        Mount external runtime data

    .PARAMETER Source
        The source path, which is the persist_dir

    .PARAMETER Target
        The target path, which is the actual path app uses to access the runtime data
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string] $Source,
        [Parameter(Mandatory = $true, Position = 1)]
        [string] $Target
    )

    if (Test-Path $Source) {
        Remove-Item $Target -Force -Recurse -ErrorAction SilentlyContinue
    }
    else {
        New-Item -ItemType Directory $Source -Force | Out-Null
        if (Test-Path $Target) {
            Get-ChildItem $Target | Move-Item -Destination $Source -Force
            Remove-Item $Target
        }
    }

    New-Item -ItemType Junction -Path $Target -Target $Source -Force | Out-Null
}

function Dismount-ExternalRuntimeData {
    <#
    .SYNOPSIS
        Unmount external runtime data

    .PARAMETER Target
        The target path, which is the actual path app uses to access the runtime data
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string] $Target
    )

    if (Test-Path $Target) {
        Remove-Item $Target -Force -Recurse
    }
}

Export-ModuleMember `
    -Function `
        New-ProfileModifier, `
        Add-ProfileContent, `
        Remove-ProfileContent, `
        Mount-ExternalRuntimeData, `
        Dismount-ExternalRuntimeData
