Write-Host "TRY GIT`n$('#' * 'TRY GIT'.Length)" -ForegroundColor green
Write-Host Git CLI en Tooling uitproberen
Write-Host Iets installeren zonder Administrator prompt zal niet lukken...

if (-not (Get-Command cinst -ErrorAction SilentlyContinue)) {
	$confirm = Read-Host "Chocolatey installeren? Geen 'cinst' (=Chocolatey Install) = exit script"
	if ($confirm) {
		iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
	} else {
		Write-Host Exiting...
		Exit
	}
}

function Install-Program {
<#
.SYNOPSIS
Ask to install something
#>
	param(
		[string]$Description,
		[string]$ChocolateyKey
	)

	Write-Host "$ChocolateyKey`n$('#' * $ChocolateyKey.Length)" -ForegroundColor magenta
	Write-Output $Description
	$confirm = Read-Host "$ChocolateyKey installeren? (enter om te skippen)"
	if ($confirm) {
		cinst -y $ChocolateyKey
	}
}



Install-Program -ChocolateyKey git -Description "Git zelf... Deze heb je sowieso nodig :)"