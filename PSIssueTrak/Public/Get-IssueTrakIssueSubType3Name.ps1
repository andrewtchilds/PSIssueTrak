function Get-IssueTrakIssueSubType3Name
{
    [CmdletBinding()]
    [Alias()]
    Param()

    $apiCall = @{
        #Body = ""
        RestMethod = "/api/v1/issuesubtypes3"
        Method = "GET"
    }

    $Results = Invoke-IssueTrakAPI @apiCall

    foreach ($Result in $Results) {
        $Result
    }
}