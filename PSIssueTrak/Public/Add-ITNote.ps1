function Add-ITNote
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$IssueNumber,
        [Parameter(Mandatory=$true)]
        [string]$Note,
        [Parameter(Mandatory=$false)]
        [string]$CreatedDate = [datetime]::UtcNow.ToString("O"),
        [Parameter(Mandatory=$true)]
        [string]$CreatedBy,
        [Parameter(Mandatory=$false)]
        [string]$SuppressEmail = "false",
        [Parameter(Mandatory=$false)]
        [string]$IsPrivate = "false",
        [Parameter(Mandatory=$false)]
        [string]$IsRichText = "false"
    )

    $Body = @{
        IssueNumber = $IssueNumber
        CreatedDate = "$CreatedDate"
        CreatedBy = "$CreatedBy"
        ShouldSuppressEmailForCreateOperation = "$SuppressEmail"
        NoteText = "$Note"
        IsPrivate = "$IsPrivate"
        IsRichText = "$IsRichText"
    }

    $apiCall = @{
        Body = $Body
        RestMethod = "/api/v1/notes"
        Method = "POST"
    }


    $Results = Invoke-IssueTrakAPI @apiCall

    foreach ($Result in $Results) {
        $Result
    }

}