###########################
# macOS-AllHosts Settings #
###########################

if (-not $IsMacOS) {
    return
}

#
# envs / global vars
#

## Define OneDrive variable
if (-not $env:OneDrive) {
    function Get-OneDriveRoot {
        [OutputType([System.IO.DirectoryInfo])]
        param (
            # Set the type of $env:OneDrive.
            # The default is commercial.
            # The other option is consumer.
            # [ValidateSet('Commercial', 'Consumer')]
            # [string] $Type = 'Commercial'
        )

        if ($IsWindows) {
            Get-ChildItem -LiteralPath $HOME -Include 'OneDrive - *'
        } elseif ($IsMacOS) {
            Get-ChildItem -LiteralPath $HOME/Library/CloudStorage -Include OneDrive* -Exclude OneDrive-個人用
        } elseif ($IsWSL) {
            Get-ChildItem -LiteralPath /mnt/c/Users -Depth 1 -Filter 'OneDrive - *'
        } elseif ($IsLinux) {
            ;
        } else {
            ;
        }
    }

    $env:OneDrive = (Get-OneDriveRoot).FullName
}

#
# functions
#

function Initialize-Homebrew {
    param (
        [ValidateScript({ Test-Path -PathType Container $_ })]
        [string] $HomebrewPrefix = '/opt/homebrew'
    )
    if (Test-Path $HomebrewPrefix) {
        ${env:HOMEBREW_PREFIX} = $HomebrewPrefix
    }
    if (Test-Path Env:/HOMEBREW_PREFIX) {
        $env:HOMEBREW_CELLAR = "${env:HOMEBREW_PREFIX}/Cellar"
        $env:HOMEBREW_REPOSITORY = "${env:HOMEBREW_PREFIX}/Homebrew"
        if ($env:PATH -notcontains "${env:HOMEBREW_PREFIX}/bin") {
            $env:PATH = "${env:HOMEBREW_PREFIX}/bin:${env:HOMEBREW_PREFIX}/sbin:${env:PATH}"
        }
        if (Test-Path Env:/MANPATH) {
            if ($env:MANPATH -notcontains "${env:HOMEBREW_PREFIX}/share/man") {
                $env:MANPATH = "${env:HOMEBREW_PREFIX}/share/man:${env:MANPATH}"
            }
        } else {
            $env:MANPATH = "${env:HOMEBREW_PREFIX}/share/man"
        }
        if (Test-Path Env:/INFOPATH) {
            if ($env:INFOPATH -notcontains "${env:HOMEBREW_PREFIX}/share/info") {
                $env:INFOPATH = "${env:HOMEBREW_PREFIX}/share/info:${env:INFOPATH}"
            }
        } else {
            $env:INFOPATH = "${env:HOMEBREW_PREFIX}/share/info"
        }
    }
}

#
# main
#

Initialize-Homebrew
