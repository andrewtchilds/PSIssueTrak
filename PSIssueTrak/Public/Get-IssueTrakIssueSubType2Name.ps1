function Get-IssueTrakIssueSubType2Name
{
    [CmdletBinding()]
    [Alias()]
    Param()

    $apiCall = @{
        #Body = ""
        RestMethod = "/api/v1/issuesubtypes2"
        Method = "GET"
    }

    $Results = Invoke-IssueTrakAPI @apiCall

    foreach ($Result in $Results) {
        $Result
    }
}