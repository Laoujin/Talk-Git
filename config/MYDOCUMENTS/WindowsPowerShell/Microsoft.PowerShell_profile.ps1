# Plaats in c:\users\username\documents\WindowsPowerShell

# Laadt automatisch Posh-Git
# Onderaan worden wat kleurtjes gewijzigd

Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

# Define aliases
${function:code} = { Set-Location "c:\code\" }

# Load posh-git module from current directory
#Import-Module .\posh-git

# If module is installed in a default location ($env:PSModulePath),
# use this instead (see about_Modules for more information):
Import-Module Posh-Git

# Set up a simple prompt, adding the git prompt parts inside git repos
function global:prompt {
	$realLASTEXITCODE = $LASTEXITCODE

	# Reset color, which can be messed up by Enable-GitColors
	$Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

	Write-Host("`n$($pwd.ProviderPath)") -nonewline -ForegroundColor blue

	Write-VcsStatus

	$global:LASTEXITCODE = $realLASTEXITCODE
	return "> "
}

Enable-GitColors

Pop-Location

Start-SshAgent -Quiet

# Change colors
$global:GitPromptSettings.WorkingForegroundColor = [ConsoleColor]::Yellow
$global:GitPromptSettings.UntrackedForegroundColor = [ConsoleColor]::Yellow
$global:GitPromptSettings.BranchForegroundColor = [ConsoleColor]::Green

$hostColors = (Get-Host).PrivateData
$hostColors.ErrorForegroundColor = "DarkMagenta"
#$Host.UI.RawUI.ForegroundColor = 