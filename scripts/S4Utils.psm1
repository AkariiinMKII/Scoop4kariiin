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

    $SupportedType = @("ImportModule")

    if ($SupportedType -notcontains $Type) {
        Write-Host "Error: Unsupported type." -ForegroundColor Red
        Return
    }

    $ScoopDir = Split-Path $BucketDir | Split-Path
    $AppDir = Join-Path -Path $ScoopDir -ChildPath "\apps\$Name\current\"
    $S4UtilsPath = Join-Path -Path $BucketDir -ChildPath "\scripts\S4Utils.psm1"

    switch ($Type) {
        {$_ -eq "ImportModule"} {
            'add-profile-content', 'remove-profile-content' | ForEach-Object {
                $TempletPath = Join-Path -Path $BucketDir -ChildPath "\scripts\S4Templates\$_.ps1"
                if (-not(Test-Path $TempletPath)) {
                    Write-Host 'Missing files, please update scoop buckets and reinstall this app.' -ForegroundColor Red
                    Return
                }
                $Content = ("'", "Import-Module ", $Name, "'") -Join("")
                $ProfileContent = Get-Content -Path $TempletPath
                $ProfileContent = $ProfileContent.Replace('$S4UtilsPath',$S4UtilsPath)
                $ProfileContent = $ProfileContent.Replace('$Content',$Content)
                $ProfileContent | Set-Content -Path "$AppDir\$_.ps1" -Encoding utf8
            }
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

    if (!(test-path $PROFILE)) {
        New-Item -Path $PROFILE -Value "$Content" -ItemType File -Force | Out-Null
    }
    else {
        Add-Content -Path $PROFILE -Value "`n$Content" -NoNewLine
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

    ((Get-Content -Path $PROFILE -raw) -replace "[\r\n]*$Content",'').trim() | Set-Content $PROFILE -NoNewLine
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
