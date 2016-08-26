function Get-IssueTrakIssueSubTypeName
{
    [CmdletBinding()]
    [Alias()]
    Param()

    $apiCall = @{
        #Body = ""
        RestMethod = "/api/v1/issuesubtypes"
        Method = "GET"
    }

    $Results = Invoke-IssueTrakAPI @apiCall

    foreach ($Result in $Results) {
        $Result
    }
}