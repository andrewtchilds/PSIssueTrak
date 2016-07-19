function Get-ITIssue
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$IssueNumber
    )

    $apiCall = @{
        #Body = ""
        RestMethod = "/api/v1/issues/true/$IssueNumber"
        Method = "GET"
    }


    $Results = Invoke-IssueTrakAPI @apiCall

    foreach ($Result in $Results) {
        $Result
    }
}