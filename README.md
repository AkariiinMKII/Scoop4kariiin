# Scoop4kariiin

[![Tests](https://github.com/AkariiinMKII/Scoop4kariiin/actions/workflows/ci.yml/badge.svg)](https://github.com/AkariiinMKII/Scoop4kariiin/actions/workflows/ci.yml) [![Excavator](https://github.com/AkariiinMKII/Scoop4kariiin/actions/workflows/excavator.yml/badge.svg)](https://github.com/AkariiinMKII/Scoop4kariiin/actions/workflows/excavator.yml)
![GitHub](https://img.shields.io/github/license/AkariiinMKII/Scoop4kariiin?logo=unlicense&logoColor=959DA5&labelColor=292D32&color=32CD32&link=https%3A%2F%2Fgithub.com%2FAkariiinMKII%2FScoop4kariiin%2Fblob%2Fmain%2FLICENSE)
![GitHub repo size](https://img.shields.io/github/repo-size/AkariiinMKII/Scoop4kariiin?logo=github&logoColor=959DA5&labelColor=292D32)

A bucket for [Scoop](https://github.com/ScoopInstaller/Scoop), the Windows command-line installer.

## How do I install these manifests?

Simply run following commands:

```PowerShell
#Add this bucket to your scoop
scoop bucket add Scoop4kariiin https://github.com/AkariiinMKII/Scoop4kariiin

#Install apps by manifest name
scoop install <manifest> # Use Scoop4kariiin/<manifest> if app name conflicts with ones in other bucket.
```

## How do I contribute new manifests?

To make a new manifest contribution, please read the [Contributing Guide](https://github.com/ScoopInstaller/.github/blob/main/.github/CONTRIBUTING.md).

Additionally, here is [a tiny toolkit](scripts/README.md) to help building app manifests.
