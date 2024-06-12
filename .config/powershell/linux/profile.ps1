###########################
# Linux-AllHosts Settings #
###########################

if (-not $IsLinux) {
    return
}

#
# envs / global vars
#

$global:IsWSL = if (Test-Path /etc/wsl.conf) {
    $true
} else {
    $false
}

## Define OneDrive variable
if (-not $env:OneDrive) {
    function Get-OneDriveRoot {
        [OutputType([string])]
        param (
            # Set the type of $env:OneDrive.
            # The default is commercial.
            # The other option is consumer.
            # [ValidateSet('Commercial', 'Consumer')]
            # [string] $Type = 'Commercial'
        )

        if ($IsWSL) {
            Get-ChildItem -LiteralPath /mnt/c/Users -Depth 1 -Filter 'OneDrive - *' | Select-Object -Last 1 -Property FullName
        } elseif ($IsLinux) {
            ''
        } else {
            ''
        }
    }

    $env:OneDrive = Get-OneDriveRoot
}

#
# functions
#

function Initialize-Homebrew {
    param (
        [ValidateScript({ Test-Path -PathType Container $_ })]
        [string] $HomebrewPrefix = '/home/linuxbrew/.linuxbrew'
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
