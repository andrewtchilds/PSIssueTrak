function Set-PSIssueTrakConfig {
    <#
        .SYNOPSIS
            Set PSIssueTrak module configuration.

        .DESCRIPTION
            Set PSIssueTrak module configuration, and the $PSIssueTrakConfig global variable.

            This data is used as the default for most commands.

        .PARAMETER Uri
            Specify a Uri to use

        .PARAMETER APIKey
            Specify an API key to use

        .Example

            $Uri = 'https://IssueTrak.Example:443'

            $APIKey = 'yourAPIKey'

            Set-PSIssueTrakConfig -Uri $Uri -APIKey $APIKey

        .FUNCTIONALITY
            PSIssueTrak
    #>
    [CmdletBinding()]
    param(
        [string]$Uri,
        [string]$APIKey
    )

    try {
        $Existing = Get-PSIssueTrakConfig -ErrorAction stop
    }
    catch {
        throw "Error getting PSIssueTrak config: $_"
    }

    foreach($Key in $PSBoundParameters.Keys) {
        if(Get-Variable -name $Key) {
            $Existing | Add-Member -MemberType NoteProperty -Name $Key -Value $PSBoundParameters.$Key -Force
        }
    }

    #Write the global variable and the xml
    $Global:PSIssueTrakConfig = $Existing
    $Existing | Select -Property * | Export-Clixml -Path "$PSScriptRoot\..\PSIssueTrak.xml" -Force
}