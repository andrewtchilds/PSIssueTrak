function Get-IssueTrakIssueTypeName
{
    $apiCall = @{
        #Body = ""
        RestMethod = "/api/v1/issuetypes"
        Method = "GET"
    }

    $Results = Invoke-IssueTrakAPI @apiCall

    foreach ($Result in $Results) {
        $Result
    }
}