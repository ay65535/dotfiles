#############################
# Windows-AllHosts Settings #
#############################

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

        Get-ChildItem -LiteralPath $HOME -Include 'OneDrive - *'
    }

    $env:OneDrive = (Get-OneDriveRoot).FullName
}


switch ($Host.Name) {
    'ConsoleHost' {

        function Enable-PSFzf {
            # https://github.com/kelleyma49/PSFzf
            Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
        }

        function Enable-PoshGit {
            Import-Module posh-git

            # https://github.com/dahlbyk/posh-git#using-posh-git
            if ((Get-Module posh-git).Version.Major -gt 0) {
                $GitPromptSettings.DefaultPromptWriteStatusFirst = $false
            }
            # {DPPrefix}{DPPath}{PathStatusSeparator}<{BeforeStatus}{Status}{AfterStatus}>{DPBeforeSuffix}<{DPDebug}><{DPTimingFormat}>{DPSuffix}
            # {DPPrefix}<{BeforeStatus}{Status}{AfterStatus}>{PathStatusSeparator}{DPPath}{DPBeforeSuffix}<{DPDebug}><{DPTimingFormat}>{DPSuffix}
            #$GitPromptSettings.DefaultPromptPrefix.Text = '`n' + $(Get-PromptConnectionInfo -Format '[{1}@{0}]: ') + '$([DateTime]::now.ToString("M/d dddd H:mm:ss", [Globalization.CultureInfo]::InvariantCulture)) '
            #$GitPromptSettings.DefaultPromptPrefix.Text = '`n$(Get-PromptConnectionInfo)$([DateTime]::now.ToString("M/d dddd H:mm:ss", [Globalization.CultureInfo]::InvariantCulture)) '
            $GitPromptSettings.DefaultPromptPrefix.Text = '`n$(Get-PromptConnectionInfo)$([DateTime]::now.ToString("M/d (ddd) H:mm:ss")) '
            $GitPromptSettings.DefaultPromptPrefix.ForegroundColor = ([ConsoleColor]::DarkGray)
            $GitPromptSettings.DefaultPromptPath.ForegroundColor = ([ConsoleColor]::Cyan)
            $GitPromptSettings.DefaultPromptPath.Text = '$(Get-PromptPath)`n'
            $GitPromptSettings.PathStatusSeparator = ''
            function global:PromptWriteErrorInfo() {
                if ($global:GitPromptValues.DollarQuestion) { return }

                if ($global:GitPromptValues.LastExitCode) {
                    "`e[31m(" + $global:GitPromptValues.LastExitCode + ")`e[0m '
                        } else {
                            '`e[31m!`e[0m"
                }
            }
            $global:GitPromptSettings.DefaultPromptBeforeSuffix.Text = '$(PromptWriteErrorInfo)'
            $GitPromptSettings.DefaultPromptSuffix = '$('>' * ($nestedPromptLevel + 1)) '
        }

    }
    'Visual Studio Code Host' {}
    default {}
}

# . $PSScriptRoot\winget.ps1
