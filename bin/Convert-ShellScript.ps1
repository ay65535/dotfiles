<#
.SYNOPSIS
    Converts shellscript content to PowerShell script
.INPUTS
    System.String
.OUTPUTS
    System.String
.EXAMPLE
    ./Convert-ShellScript.ps1 "echo 'Hello World'"
.EXAMPLE
    "echo 'Hello World'" | ./Convert-ShellScript.ps1
.EXAMPLE
    Get-Content -Raw ./hello.sh | ./Convert-ShellScript.ps1 | Out-File ./hello.ps1
#>
[CmdletBinding()]
[OutputType([string])]
param (
    # Specifies shellscript content
    [Parameter(Position = 0, ValueFromPipeline)]
    [string] $InputObject
    ,
    [Parameter(DontShow)]
    [switch] $Execute
)

function Convert-ShellScript {
    <#
    .SYNOPSIS
        Converts shellscript content to PowerShell script
    .INPUTS
        System.String
    .OUTPUTS
        System.String
    .EXAMPLE
        . ./Convert-ShellScript.ps1
        Convert-ShellScript "echo 'Hello World'"
    .EXAMPLE
        . ./Convert-ShellScript.ps1
        "echo 'Hello World'" | Convert-ShellScript
    .EXAMPLE
        . ./Convert-ShellScript.ps1
        Get-Content -Raw ./hello.sh | Convert-ShellScript | Out-File ./hello.ps1
    #>
    [CmdletBinding()]
    [OutputType([string])]
    param (
        # Specifies shellscript content
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string] $InputObject
    )

    process {
        try {
            $buff = $InputObject `
                -replace '^#!/.*', '#!/usr/bin/env pwsh' `
                -replace '"\$\(cd "\$\(dirname "\$0"\)" && pwd\)"', '$PSScriptRoot' `
                -replace '\becho\b', 'Write-Host' `
                -replace '\bls\b', 'Get-ChildItem' `
                -replace '\bcd\b', 'Set-Location' `
                -replace '\bpwd\b', 'Get-Location' `
                -replace '\bgrep -v', 'Select-String -NotMatch' `
                -replace '\bgrep\b( -E)?', 'Select-String' `
                -replace '\bmkdir(?: -p)?\b', 'New-Item -ItemType Directory' `
                -replace '\bln -[a-zA-Z]*s[a-zA-Z]*\b', 'New-Item -ItemType SymbolicLink -Target' `
                -replace '\$\?', '$$LASTEXITCODE' `
                -replace '["''](.*)["'']\*', '"$1*"' `
                -replace 'set -[ex]?u.*(?=\n)', 'Set-StrictMode -Version Latest' `
                -replace 'set -x.*(?=\n)', 'Set-PSDebug -Trace 2' `
                -replace 'set \+x.*(?=\n)', 'Set-PSDebug -Off' `
                -replace '(\n *)(?:local )?(\w+)([/*+-]*=)\((.*)\)', '$1$$$2 $3 @($4)' `
                -replace '(\n *)(?:local )?(\w+)([/*+-]*=)', '$1$$$2 $3 ' `
                -replace '(?:function )?(\w+) \(\)\s*{', 'function $1 {' `
                -replace 'case (.*) in', 'switch ($1) {' `
                -replace ' *(.*)\)(.*)\s*;;', '{$1} {$2}' `
                -replace ' *\*\)(.*)\s*(?:;;|\nesac)', "default {`$1}`n}" `
                -replace '\b(?:fi|esac|done)\b', '}' `
                -replace '\belif\b', '} elseif' `
                -replace 'for (.*) in (.*)(?=; do\b)', 'foreach ($$$1 in $2)' `
                -replace '[;\n] *\b(?:then|do)\b', ' {' `
                -replace '\[\[? (.*?) \]\]? && \[\[? (.*?) \]\]?', '(($1) -and ($2))' `
                -replace '\[\[? (.*?) \]\]? \|\| \[\[? (.*?) \]\]?', '(($1) -or ($2))' `
                -replace '[\[(]\[? *(.*?) == (.*?) *[)\]]\]?', '($1 -eq $2)' `
                -replace '[\[(]\[? *(.*?) != (.*?) *[)\]]\]?', '($1 -ne $2)' `
                -replace '\[\[? (.*)-[efd] (.*) \]\]?', '($1(Test-Path $2))' `
                -replace '1?>&2', '| Write-Warning' `
                -replace '"\${(\w+)\[\@\]}"', '$$$1'
            $buff = [regex]::Replace($buff, '"\$(\d+)"', { '$Args[' + ([int]$args.groups[1].value - 1) + ']' })
            $buff
        } catch {
            $PSCmdlet.ThrowTerminatingError($PSItem)
        }
    }
}

if ($MyInvocation.InvocationName -ne '.' -or $Execute) {
    if ($MyInvocation.ExpectingInput) {
        $InputObject | Convert-ShellScript
    } else {
        Convert-ShellScript -InputObject $InputObject
    }
}
