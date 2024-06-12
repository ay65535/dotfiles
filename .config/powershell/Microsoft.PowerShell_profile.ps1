#####################################
# AllPlatforms-ConsoleHost Settings #
#####################################

if ($LoadedProfiles -contains $PSCommandPath) {
    return  # If already loaded, just return.
} else {
    # Add to flag
    $global:LoadedProfiles += $PSCommandPath
}

## 1Password
# if (Get-Command op -ErrorAction SilentlyContinue) {
#     $opCompletionPath = $PROFILE.CurrentUserAllHosts | Split-Path | Join-Path -ChildPath op-completion.ps1
#     function Update-OpCompletionScript {
#         op completion powershell | Out-String | Out-File -Encoding $encoding $opCompletionPath
#     }

#     if (!(Test-Path $opCompletionPath)) {
#         Update-OpCompletionScript
#     }
#     . $opCompletionPath
# }

# Load platform-specific profile
if (Test-Path "$scriptRoot/$Platform/Microsoft.PowerShell_profile.ps1") {
    . "$scriptRoot/$Platform/Microsoft.PowerShell_profile.ps1"
}
