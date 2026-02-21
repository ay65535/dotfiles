#Requires -RunAsAdministrator
<#
.SYNOPSIS
    指定した実行ファイルに対して、Windows Error Reporting (WER) のダンプ設定をレジストリから削除します。
.EXAMPLE
    Unregister-WERDump -ExeName DFCM.exe
#>
param (
    [Parameter(Mandatory)]
    [string] $ExeName
)

function Unregister-WERDump {
    <#
    .SYNOPSIS
        指定した実行ファイルに対して、Windows Error Reporting (WER) のダンプ設定をレジストリから削除します。
    .EXAMPLE
        Unregister-WERDump -ExeName DFCM.exe
    #>
    param (
        [Parameter(Mandatory)]
        [string] $ExeName
    )
    $p = "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps\$ExeName"
    Remove-Item -Path $p -Recurse -Force
}

if ($MyInvocation.InvocationName -eq '.') {
    Write-Verbose 'This script is being dot-sourced.'
    return
}

Unregister-WERDump -ExeName $ExeName
