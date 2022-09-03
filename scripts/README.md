# About [S4Utils](S4Utils.psm1)

_A PowerShell module for this bucket, which contains several functions to help building app manifests._

## Functions

- [New-ProfileModifier](#new-profilemodifier)
- [Add-ProfileContent](#add-profilecontent)
- [Remove-ProfileContent](#remove-profilecontent)
- [Mount-ExternalRuntimeData](#mount-externalruntimedata)
- [Dismount-ExternalRuntimeData](#dismount-externalruntimedata)

----

### `New-ProfileModifier`

_Generate scripts which modifies PowerShell profile._

|Parameters|Type|Mandatory|Descriptions|
|----|:----:|:----:|----|
|`Type`|String|&check;|Type of scripts to generate, support `ImportModule`, `RemoveModule` in current version.|
|`Name`|String|&check;|Use the name of manifest file.|
|`BucketDir`|String|&check;|Path of Scoop4kariiin bucket root directory, use `Find-BucketDirectory -Root -Name Scoop4kariiin` in manifest to get the value.|
|`ModuleName`|String|&cross;|Value of `name` in `psmodule` field, use this parameter if it differs from manifest name.|

- See [Windows-screenFetch manifest](../bucket/Windows-screenFetch.json) for example.

----

### `Add-ProfileContent`

_Add certain content to PowerShell profile. Scripts generated by `New-ProfileModifier` will call this function._

|Parameters|Type|Mandatory|Descriptions|
|----|:----:|:----:|----|
|`Content`|String|&check;|Content to be added.|

- See [Windows-screenFetch manifest](../bucket/Windows-screenFetch.json) for example.

----

### `Remove-ProfileContent`

_Remove certain content from PowerShell profile. Scripts generated by `New-ProfileModifier` will call this function._

|Parameters|Type|Mandatory|Descriptions|
|----|:----:|:----:|----|
|`Content`|String|&check;|Content to be removed.|

- See [Windows-screenFetch manifest](../bucket/Windows-screenFetch.json) for example.

----

### `Mount-ExternalRuntimeData`

_Mount external runtime data._

|Parameters|Type|Mandatory|Descriptions|
|----|:----:|:----:|----|
|`Source`|String|&check;|Source folder persisted in `$persist_dir`, support `Persist` as alias.|
|`Target`|String|&cross;|The target path, which is the actual path app uses to access the runtime data.|
|`AppData`|Switch|&cross;|Use this parameter if target folder locates in `$env:APPDATA` using the name of persisted folder, value of `$Target` will be forced overwritten.|

- Either `Target` or `AppData` should be specified.
- See [lne-link manifest](../bucket/lne-link.json) for example.

----

### `Dismount-ExternalRuntimeData`

_Unmount external runtime data._

|Parameters|Type|Mandatory|Descriptions|
|----|:----:|:----:|----|
|`Path`|String|&check;|The target path, which is the actual path app uses to access the runtime data, support `Name`, `Target` as alias. Or just use the folder name with `AppData` parameter.|
|`AppData`|Switch|&cross;|Use this parameter if target folder locates in `$env:APPDATA` using the name of persisted folder, value of `$Path` will be forced overwritten.|

- See [lne-link manifest](../bucket/lne-link.json) for example.

----

## Use in manifests

```PowerShell
# Get the path of S4Utils.
$S4UtilsPath = Find-BucketDirectory -Root -Name Scoop4kariiin | Join-Path -ChildPath "scripts\S4Utils.psm1"

# Import and use if exists.
if (Test-Path $S4UtilsPath) {
    Unblock-File $S4UtilsPath # Unblock file to avoid permission issues.
    Import-Module $S4UtilsPath

    ... # Call functions according to demands.

    Remove-Module -Name S4Utils # Remove it to avoid conflicts.
}
```