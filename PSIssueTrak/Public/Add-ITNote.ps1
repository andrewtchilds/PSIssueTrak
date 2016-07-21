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
        [string]$NoteText,
        
        [Parameter(Mandatory=$false)]
        [string]$CreatedDate = [datetime]::UtcNow.ToString("O"),
        
        [Parameter(Mandatory=$true)]
        [ValidateScript({ if(Get-ITUser -UserID $_){ $true } })]
        [string]$CreatedBy,
        
        [Parameter(Mandatory=$false)]
        [ValidateSet("true","false")]
        [string]$ShouldSuppressEmailForCreateOperation = "false",
        
        [Parameter(Mandatory=$false)]
        [ValidateSet("true","false")]
        [string]$IsPrivate = "false",

        [Parameter(Mandatory=$false)]
        [ValidateSet("true","false")]
        [string]$IsRichText = "false"
    )

    $Body = @{
        IssueNumber = $IssueNumber
        CreatedDate = "$CreatedDate"
        CreatedBy = "$CreatedBy"
        ShouldSuppressEmailForCreateOperation = "$ShouldSuppressEmailForCreateOperation"
        NoteText = "$NoteText"
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
        [PSCustomObject]@{NoteID=$Result}
    }
}