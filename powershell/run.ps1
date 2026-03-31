Import-Module $PWD/powershell/copy.psm1
$config = Get-Content -Path "$PWD\config.json" | ConvertFrom-Json
Copy-Folders -SourcePaths $config.sources -Destination $config.destination -Recurse:$config.recurse -Force:$config.force
write-host "Copying completed."

