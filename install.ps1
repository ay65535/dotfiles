#!/usr/bin/env pwsh

Set-StrictMode -Version Latest

#
# Script Variables
#

# scriptRoot=$HOME/.dotfiles
$scriptRoot = $PSScriptRoot

#
# Functions
#

function symlink_to_home {
    param (
        # filename to symlink
        [string] $LinkName
    )

    $linkDir = $HOME
    $linkPath = Join-Path $linkDir $LinkName
    $origFullPath = Join-Path $scriptRoot $LinkName

    # check original file existence
    if (!(Test-Path "$origFullPath")) {
        Write-Host "$origFullPath is not found, do nothing." | Write-Warning
        return
    }

    # check symlink existence
    if ((Test-Path "$linkPath")) {
        Write-Host "$linkPath is already exists, do nothing." | Write-Warning
        return
    }

    # get relative path
    $origRelPath = [IO.Path]::GetRelativePath($linkDir, "$origFullPath")

    New-Item -ItemType SymbolicLink -Target "$origRelPath" "$linkPath"
}

#
# Main
#

$target = Get-ChildItem -Force "$scriptRoot" -Filter '.*' -Exclude '.git*'
$target += Get-Item bin

foreach ($f in $target.Name) {
    symlink_to_home "$f"
}

# check os
if (Test-Path Variables:/OSTYPE) {
    if ($OSTYPE -match '(linux|darwin|msys).*') {
        $OSDIR = $Matches[1]
    }
} elseif ($env:OS -and $env:OS -match 'Windows') {
    $OSDIR = 'windows'
} else {
    $OSDIR = 'unknown'
}

# setup .gitconfig

if (git config --get-all include.path | Select-String -Quiet config.core) {
    if (!(Test-Path "$HOME/.gitconfig")) {
        git config --file "$scriptRoot/.config/git/config" --add include.path config.core

        if ((git config --get-all include.path | Select-String -Quiet $OSDIR/config) -and ("$OSDIR" -ne 'unknown')) {
            git config --file "$scriptRoot/.config/git/config" --add include.path $OSDIR/config
        }

    } elseif (Test-Path "$HOME/.gitconfig") {
        git config --add include.path config.core

        if ((git config --get-all include.path | Select-String -Quiet $OSDIR/config) -and ("$OSDIR" -ne 'unknown')) {
            git config --add include.path $OSDIR/config
        }

        if (Test-Path "$scriptRoot/.config/git/config") {
            Write-Host 'both ~/.gitconfig and ~/.config/git/config exists.'
        }
    }
}

# setup bash_completion
if (!(Test-Path "$HOME/.local/share/bash-completion/completions")) {
    New-Item -ItemType Directory "$HOME/.local/share/bash-completion/completions"
}
