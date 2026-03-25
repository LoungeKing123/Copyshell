# Powershell Cloner

## Configuration template

Create and edit `config.json` at the repository root to provide a reusable
set of sources and a destination. Example keys:

- `sources`: array of folder paths
- `destination`: single target folder
- `recurse`: true/false
- `force`: true/false

Example usage (requires `powershell-yaml` or similar to parse YAML):

```powershell
# Install the YAML helper if needed:
Install-Module -Name powershell-yaml -Scope CurrentUser

$cfg = Get-Content -Path .\config.yaml | ConvertFrom-Yaml
Copy-Folders -SourcePaths $cfg.sources -Destination $cfg.destination -Recurse:$cfg.recurse -Force:$cfg.force
```


