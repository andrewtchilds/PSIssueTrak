function Get-PSIssueTrakConfig {
    <#
        .SYNOPSIS
            Get PSIssueTrak module configuration.

        .DESCRIPTION
            Get PSIssueTrak module configuration

        .FUNCTIONALITY
            PSIssueTrak
    #>
    [CmdletBinding()]
    param(
        [ValidateSet("Variable","ConfigFile")]$Source = "Variable"
    )

    if(-not (Test-Path -Path "$PSScriptRoot\..\PSIssueTrak.xml" -ErrorAction SilentlyContinue)) {
        try {
            Write-Verbose "Did not find config file $PSScriptRoot\..\PSIssueTrak.xml attempting to create"
            [pscustomobject]@{
                Uri = $null
                APIKey = $null
            } | Export-Clixml -Path "$PSScriptRoot\..\PSIssueTrak.xml" -Force -ErrorAction Stop
        }
        catch {
            Write-Warning "Failed to create config file $PSScriptRoot\..\PSIssueTrak.xml: $_"
        }
    }    

    if($Source -eq "Variable" -and $PSIssueTrakConfig) {
        $PSIssueTrakConfig
    }
    else {
        Import-Clixml -Path "$PSScriptRoot\..\PSIssueTrak.xml"
    }
}