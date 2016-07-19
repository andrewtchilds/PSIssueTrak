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

    if(-not (Test-Path -Path "$PSScriptRoot\PSIssueTrak_$($env:USERNAME).xml" -ErrorAction SilentlyContinue)) {
        try {
            Write-Verbose "Did not find config file $PSScriptRoot\PSIssueTrak_$($env:USERNAME).xml attempting to create"
            [pscustomobject]@{
                Uri = $null
                APIKey = $null
            } | Export-Clixml -Path "$PSScriptRoot\PSIssueTrak_$($env:USERNAME).xml" -Force -ErrorAction Stop
        }
        catch {
            Write-Warning "Failed to create config file $PSScriptRoot\PSIssueTrak_$($env:USERNAME).xml: $_"
        }
    }    

    if($Source -eq "Variable" -and $PSIssueTrakConfig) {
        $PSIssueTrakConfig
    }
    else {
        Import-Clixml -Path "$PSScriptRoot\PSIssueTrak_$($env:USERNAME).xml"
    }
}