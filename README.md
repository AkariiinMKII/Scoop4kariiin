# Scoop4kariiin

[![Tests](https://github.com/AkariiinMKII/Scoop4kariiin/actions/workflows/ci.yml/badge.svg)](https://github.com/AkariiinMKII/Scoop4kariiin/actions/workflows/ci.yml) [![Excavator](https://github.com/AkariiinMKII/Scoop4kariiin/actions/workflows/excavator.yml/badge.svg)](https://github.com/AkariiinMKII/Scoop4kariiin/actions/workflows/excavator.yml)

A bucket for [Scoop](https://github.com/ScoopInstaller/Scoop), the Windows command-line installer.

## How do I install these manifests?

Simply run following commands:

```PowerShell
#Add this bucket to your scoop
scoop bucket add Scoop4kariiin https://github.com/AkariiinMKII/Scoop4kariiin

#Install apps by manifest name
scoop install <manifest>
```

## How do I contribute new manifests?

To make a new manifest contribution, please read the [Contributing Guide](https://github.com/ScoopInstaller/.github/blob/main/.github/CONTRIBUTING.md).

Additionally, here is [a tiny toolkit](scripts/README.md) to help building app manifests.
