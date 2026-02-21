#Requires -RunAsAdministrator
<#
.SYNOPSIS
    指定した実行ファイルに対して、Windows Error Reporting (WER) のダンプ設定をレジストリに登録します。
.EXAMPLE
    Register-WERDump -ExeName MyApp.exe -DumpFolder C:\temp\MyApp -DumpType 2
.LINK
    https://learn.microsoft.com/ja-jp/windows/win32/wer/collecting-user-mode-dumps
#>
param (
    [Parameter(Mandatory)]
    [string] $ExeName,
    # ダンプ ファイルを格納するパス。 既定のパスを使用しない場合は、クラッシュ プロセスがフォルダーにデータを書き込むことを許可する ACL がフォルダーに含まれていることを確認してください。
    # サービスのクラッシュの場合、ダンプは、使用されるサービス アカウントに応じてサービス固有のプロファイル フォルダーに書き込まれます。
    # たとえば、システム サービスのプロファイル フォルダーは %WINDIR%\System32\Config\SystemProfile です。
    # ネットワークとローカルのサービスの場合、フォルダーは %WINDIR%\ServiceProfiles です。
    [string] $DumpFolder = "$env:LOCALAPPDATA\CrashDumps",
    # The maximum number of dump files in the folder.
    # When the maximum value is exceeded, the oldest dump file in the folder will be replaced with the new dump file.
    [int] $DumpCount = 10,
    # DumpType: 0 = Custom dump, 1 = Mini dump, 2: Full dump
    [ValidateSet(0, 1, 2)]
    [int] $DumpType = 1
)

if (-not $IsWindows) {
    throw 'This script can only run on Windows.'
}

function Register-WERDump {
    <#
    .SYNOPSIS
        指定した実行ファイルに対して、Windows Error Reporting (WER) のダンプ設定をレジストリに登録します。
    .EXAMPLE
        Register-WERDump -ExeName MyApp.exe -DumpFolder C:\temp\MyApp -DumpType 2
    .LINK
        https://learn.microsoft.com/ja-jp/windows/win32/wer/collecting-user-mode-dumps
    #>
    param (
        [Parameter(Mandatory)]
        [string] $ExeName,
        # ダンプ ファイルを格納するパス。 既定のパスを使用しない場合は、クラッシュ プロセスがフォルダーにデータを書き込むことを許可する ACL がフォルダーに含まれていることを確認してください。
        # サービスのクラッシュの場合、ダンプは、使用されるサービス アカウントに応じてサービス固有のプロファイル フォルダーに書き込まれます。
        # たとえば、システム サービスのプロファイル フォルダーは %WINDIR%\System32\Config\SystemProfile です。
        # ネットワークとローカルのサービスの場合、フォルダーは %WINDIR%\ServiceProfiles です。
        [string] $DumpFolder = "$env:LOCALAPPDATA\CrashDumps",
        # The maximum number of dump files in the folder.
        # When the maximum value is exceeded, the oldest dump file in the folder will be replaced with the new dump file.
        [int] $DumpCount = 10,
        # DumpType: 0 = Custom dump, 1 = Mini dump, 2: Full dump
        [ValidateSet(0, 1, 2)]
        [int] $DumpType = 1
    )
    $p = "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps\$ExeName"
    New-Item -Path $p -Force
    New-ItemProperty -Path $p -Name 'DumpFolder' -Value $DumpFolder -PropertyType ExpandString -Force
    New-ItemProperty -Path $p -Name 'DumpCount' -Value $DumpCount -PropertyType DWord -Force
    New-ItemProperty -Path $p -Name 'DumpType' -Value $DumpType -PropertyType DWord -Force
}

if ($MyInvocation.InvocationName -eq '.') {
    Write-Verbose 'This script is being dot-sourced.'
    return
}

Register-WERDump -ExeName $ExeName -DumpFolder $DumpFolder -DumpType $DumpType
