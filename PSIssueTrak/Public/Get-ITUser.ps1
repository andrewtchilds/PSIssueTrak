function Get-ITUser
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$UserID
    )

    $apiCall = @{
        #Body = ""
        RestMethod = "/api/v1/users/$UserID/false"
        Method = "GET"
    }

    $Results = Invoke-IssueTrakAPI @apiCall

    foreach ($Result in $Results) {
        $Result
    }
}