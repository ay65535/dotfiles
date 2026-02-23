$dotfilesPath = "$env:OneDrive\dotfiles"
if (Test-Path -Path "$dotfilesPath\.config\powershell\profile.ps1") {
    . "$dotfilesPath\.config\powershell\profile.ps1"
}
