<#
.SYNOPSIS
Copies a list of folders to a destination directory.

.DESCRIPTION
`Copy-Folders` copies one or more folder paths to a target destination. Each source
folder will be copied into the destination as a child folder. Supports `-Recurse`,
`-Force`, and PowerShell's `-WhatIf`/`-Confirm` via `SupportsShouldProcess`.

.PARAMETER SourcePaths
Array of folder paths to copy. Accepts pipeline input.

.PARAMETER Destination
Target folder where the source folders will be copied.

.PARAMETER Recurse
Copy child items recursively.

.PARAMETER Force
Overwrite existing items when copying.

.EXAMPLE
PS> Import-Module .\copy.psm1
PS> Copy-Folders -SourcePaths 'C:\proj\one','C:\proj\two' -Destination 'D:\backup' -Recurse

.EXAMPLE
PS> 'C:\data\A','C:\data\B' | Copy-Folders -Destination 'E:\archive' -WhatIf
#>
function Copy-Folders {
	[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
	param(
		[Parameter(Mandatory=$true, ValueFromPipeline=$true, Position=0)]
		[ValidateNotNullOrEmpty()]
		[string[]]
		$SourcePaths,

		[Parameter(Mandatory=$true, Position=1)]
		[ValidateNotNullOrEmpty()]
		[string]
		$Destination,

		[switch]
		$Recurse,

		[switch]
		$Force
	)

	begin {
		if (-not (Test-Path -Path $Destination)) {
			try {
				New-Item -ItemType Directory -Path $Destination -Force | Out-Null
			} catch {
				Throw "Unable to create destination path '$Destination': $_"
			}
		}
	}

	process {
		foreach ($src in $SourcePaths) {
			if ([string]::IsNullOrWhiteSpace($src)) { continue }

			if (-not (Test-Path -Path $src)) {
				Write-Warning "Source not found: $src"
				continue
			}

			$leaf = Split-Path -Path $src -Leaf
			if ([string]::IsNullOrEmpty($leaf)) { $leaf = (Get-Item -Path $src).Name }
			$destPath = Join-Path -Path $Destination -ChildPath $leaf

			if ($PSCmdlet.ShouldProcess("$src","Copy to $destPath")) {
				try {
					if (-not (Test-Path -Path $destPath)) {
						New-Item -ItemType Directory -Path $destPath -Force | Out-Null
					}

					$copyParams = @{
						Path = $src
						Destination = $destPath
						Container = $true
					}
					if ($Recurse) { $copyParams['Recurse'] = $true }
					if ($Force) { $copyParams['Force'] = $true }

					Copy-Item @copyParams
				} catch {
					Write-Error "Failed copying '$src' to '$destPath' - $($_.Exception.Message)"
				}
			}
		}
	}
}

Export-ModuleMember -Function Copy-Folders

