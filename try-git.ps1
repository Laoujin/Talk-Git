function Write-Title($title, $color = 'magenta') {
	Write-Host
	$titleHeader = "#" * ($title.length + 6)
	Write-Host $titleHeader -ForegroundColor $color
	Write-Host "## $title ##" -ForegroundColor $color
	Write-Host $titleHeader -ForegroundColor $color
}

cls
Write-Title "TRY GIT" darkgreen
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
		[string]$ChocolateyKey,
		[string]$Site,
		[string]$Thumbs
	)

	Write-Title $ChocolateyKey
	if ($Thumbs.Length -ne 0) {
		$likeText = if ($Thumbs -eq 'up') {"You may like"} else {"You probably won't like"}
		Write-Host "Evaluation: $likeText" -ForegroundColor magenta
	}
	Write-Output $Description
	if ($Site) {
		Write-Host "Url: $Site"
	}
	$confirm = Read-Host "Installeren? (enter om te skippen)"
	if ($confirm) {
		cinst -y $ChocolateyKey
	}
	return $confirm
}



Install-Program -ChocolateyKey 'git' -Description "Git zelf... Deze heb je sowieso nodig :)" -Site "http://git-scm.com/"

Write-Title 'COMMAND LINE' 'yellow'
Write-Verbose 'Cmder + PowerShell + Posh-Git is wat ikzelf momenteel gebruik.' -Verbose

Write-Title "Git Bash"
Write-Host "Een (beperkte) Bash shell wordt samen met Git geïnstalleerd. Plaats een ``.bashrc`` file in `$HOME (c:\users\name\). Check config/`$HOME/.bashrc en config/`$HOME/bash_prompt voor voorbeelden. Bekende dotfile repos opzoeken voor inspiratie is waarschijnlijk je beste optie op Linux/OSX. Maar dit is Windoze dus..."

Install-Program -ChocolateyKey 'git-credential-winstore' -Description "Zorgt ervoor dat je je login/paswoord op GitHub, BitBucket, ... slechts 1x moet ingeven (Enkel voor CLI)" -Site "https://gitcredentialstore.codeplex.com/"

Install-Program -Thumbs 'up' -ChocolateyKey 'cmder' -Description "Git CLI vanop een cmd.exe vervanger (ConEmu + CLink) die Control+V ondersteund (en dat is nog maar het tipje van de ijsberg). Een dag cmder en je bent vergeten wat cmd.exe was!" -Site "http://gooseberrycreative.com/cmder/"

Install-Program -Thumbs 'up' -ChocolateyKey 'poshgit' -Description "Een fancy git PowerShell prompt die de ``git status`` weergeeft. Om dit automatisch te laden met PowerShell, check config/MYDOCUMENTS/WindowsPowerShell/. Check source code comment voor installatie met PsGet." -Site "https://github.com/dahlbyk/posh-git"
# Als alternatief Posh-Git installeren met PsGet vanop PowerShell prompt:
# (new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
# Install-Module Posh-Git

# TODO: Create dir & Copy the Microsoft.PowerShell_profile.ps1 (if it doesn't yet exist)

Install-Program -Thumbs 'up' -ChocolateyKey 'cygwin' -Description "Voor diegenen die liever in een meer Linux-like omgeving werken is dit de topper. Waar Posh-Git ongeveer je enige optie is in PowerShell kun je bij Cygwin kiezen uit over de decennia gebouwde open source dotfiles..." -Site "https://www.cygwin.com/"

Write-Title 'GUI TOOLING' 'yellow'
Write-Host "GUI die bij git zit: ``gitk [--all] [filename]``. Te gebruiken voor simpele lookups want het is nogal 'ruw' :)"

Install-Program -Thumbs 'up' -ChocolateyKey 'sourcetree' -Description "Git GUI van Atlassian. De meeste collega's op ons project gebruiken deze GUI. Als je de commandline schuwt dan is dit waarschijnlijk je beste optie." -Site "http://www.sourcetreeapp.com/"
Install-Program -Thumbs 'up' -ChocolateyKey 'gitextensions' -Description "Voeg Git Extensions toe aan je Explorer ContextMenus + integratie met Visual Studio (plugin)" -Site "https://code.google.com/p/gitextensions/"

Install-Program -Thumbs 'down' -ChocolateyKey 'tortoisegit' -Description "Zoals TortoiseSVN maar dan voor Git. Misschien interessant voor mensen met SVN/Tortoise achtergrond maar is met een SVN 'mindset' gemaakt en ontbreekt daardoor Git-specifieke functionaliteit die wel in vb SourceTree zit." -Site "https://code.google.com/p/tortoisegit/"
Install-Program -Thumbs 'down' -ChocolateyKey 'githubforwindows' -Description "!!Niet nodig voor GitHub zelf!! Dit is ook gewoon een git GUI, ontwikkeld door GitHub. (en was teleurstellend de laatste keer ik geprobeerd heb - dat was weliswaar 2 jaar geleden)" -Site "https://windows.github.com/"