# Copyshell

## Configuration template

Create and edit `config.json` at the repository root to provide a reusable
set of sources and a destination.

- `sources`: array of folder paths
- `destination`: single target folder
- `recurse`: true/false
- `force`: true/false

## Operating Sytem Support

### Windows:

- Works out of the box with powershell.
- Run `powershell/run.ps1` to use

### Linux:

#### - Dnf linux (Fedora/Red Hat)

- run install-dnf.bash script
- run `powershell/run.ps1` to use
- to remove powershell use remvove-dnf.bash script

#### - Apt linux (Debian/Ubuntu)

- run install-apt.bash script
- run `powershell/run.ps1` to use
- to remove powershell use remvove-apt.bash script
- WARNING: unteseted, please open issue if there are any problems

## Upcoming Features

- Shell install script
- Documentation
- Config Command
