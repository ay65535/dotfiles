Set-StrictMode -Version Latest

new-item -itemtype symboliclink -Target "$($PWD.Path)\.config\skills\linear" -Path "$HOME\.claude\skills\linear"
#copy-item -Path "$($PWD.Path)\local\share\installers\powershell\profile.ps1" -Destination "$HOME\Documents\PowerShell\profile.ps1"
new-item -itemtype symboliclink -Target "$($PWD.Path)\local\share\installers\powershell\profile.ps1" -Path "$HOME\Documents\WindowsPowerShell\profile.ps1"
