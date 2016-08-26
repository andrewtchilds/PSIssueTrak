function Get-IssueTrakIssueSubType4Name
{
    [CmdletBinding()]
    [Alias()]
    Param()

    $apiCall = @{
        #Body = ""
        RestMethod = "/api/v1/issuesubtypes4"
        Method = "GET"
    }

    $Results = Invoke-IssueTrakAPI @apiCall

    foreach ($Result in $Results) {
        $Result
    }
}