####################################
# AllPlatforms-VSCodeHost Settings #
####################################

if ($LoadedProfiles -contains $PSCommandPath) {
    return  # If already loaded, just return.
} else {
    # Add to flag
    $global:LoadedProfiles += $PSCommandPath
}

# Load platform-specific profile
if (Test-Path "$PSScriptRoot/$Platform/Microsoft.VSCode_profile.ps1") {
    . "$PSScriptRoot/$Platform/Microsoft.VSCode_profile.ps1"
}
