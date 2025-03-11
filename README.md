# Scoop4kariiin

[![License](https://img.shields.io/github/license/AkariiinMKII/Scoop4kariiin?logo=unlicense&logoColor=959DA5&labelColor=292D32&label=License&color=34D058)](https://github.com/AkariiinMKII/Scoop4kariiin/blob/main/LICENSE)
[![Repo Size](https://img.shields.io/github/repo-size/AkariiinMKII/Scoop4kariiin?logo=github&logoColor=959DA5&labelColor=292D32&label=Repo%20Size&color=34D058)](https://github.com/AkariiinMKII/Scoop4kariiin)
[![Tests](https://github.com/AkariiinMKII/Scoop4kariiin/actions/workflows/ci.yml/badge.svg)](https://github.com/AkariiinMKII/Scoop4kariiin/actions/workflows/ci.yml)
[![Excavator](https://github.com/AkariiinMKII/Scoop4kariiin/actions/workflows/excavator.yml/badge.svg)](https://github.com/AkariiinMKII/Scoop4kariiin/actions/workflows/excavator.yml)

A bucket for [Scoop](https://github.com/ScoopInstaller/Scoop), the Windows command-line installer.

## How do I install these manifests?

Simply run following commands:

```PowerShell
# Add this bucket to your scoop
scoop bucket add Scoop4kariiin https://github.com/AkariiinMKII/Scoop4kariiin

# Install apps by manifest name
scoop install <manifest>
# If manifest name conflicts with ones in other buckets, use following command instead:
# scoop install Scoop4kariiin/<manifest>
```

> [!IMPORTANT]
> Some manifests use custom scripts stored in bucket.
>
> In this case, installing apps directly from manifest URL will fail with following error:
>
> ```Plaintext
> Missing files, please re-add Scoop4kariiin bucket and re-install this app.
> ```
>
> Please add the bucket to your device before installing.

## How do I contribute new manifests?

To make a new manifest contribution, please read the [Contributing Guide](https://github.com/ScoopInstaller/.github/blob/main/.github/CONTRIBUTING.md) and [App Manifests](https://github.com/ScoopInstaller/Scoop/wiki/App-Manifests) wiki page.

Additionally, here is a [PowerShell Script Module](https://github.com/AkariiinMKII/Scoop4kariiinUtils) to help building app manifests.
