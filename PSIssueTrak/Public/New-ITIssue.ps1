function New-ITIssue {
    [CmdletBinding()]
    [Alias()]
    Param
    (
        [Parameter(Mandatory=$false)]
        [ValidateSet("true","false")]
        [string]$ShouldSuppressEmailForCreateOperation="false",

        [Parameter(Mandatory=$false)]
        [string]$SubmittedDate=[datetime]::UtcNow.ToString("O"),

        [Parameter(Mandatory=$true)]
        [ValidateScript({ if(Get-ITUser -UserID $_){ $true } })]
        [string]$EnteredBy,
        
        [Parameter(Mandatory=$false)]
        $SeverityID=$null,
        
        [Parameter(Mandatory=$true)]
        [string]$Subject,
        
        [Parameter(Mandatory=$true)]
        [string]$Description,
        
        [Parameter(Mandatory=$false)]
        [ValidateSet("true","false")]
        [string]$IsDescriptionRichText="true",
        
        [Parameter(Mandatory=$true)]
        [string]$IssueTypeName,
        
        [Parameter(Mandatory=$false)]
        [string]$IssueSubTypeName=0,
        
        [Parameter(Mandatory=$false)]
        [string]$IssueSubType2Name=0,
        
        [Parameter(Mandatory=$false)]
        [string]$IssueSubType3Name=0,
        
        [Parameter(Mandatory=$false)]
        [string]$IssueSubType4Name=0,
        
        [Parameter(Mandatory=$false)]
        [string]$Priority="3 - Medium",
        
        [Parameter(Mandatory=$false)]
        $AssetNumber=$null,
        
        [Parameter(Mandatory=$false)]
        $LocationID=$null,
        
        [Parameter(Mandatory=$true)]
        [ValidateScript({ if(Get-ITUser -UserID $_){ $true } })]
        [string]$SubmittedBy,
        
        [Parameter(Mandatory=$true)]
        [ValidateScript({ if(Get-ITUser -UserID $_){ $true } })]
        [string]$AssignedTo,
        
        [Parameter(Mandatory=$false)]
        $TargetDate=$null,
        
        [Parameter(Mandatory=$false)]
        $RequiredByDate=$null,
        
        [Parameter(Mandatory=$false)]
        [ValidateScript({ if(Get-ITUser -UserID $_){ $true } })]
        $NextActionTo=$null,
        
        [Parameter(Mandatory=$false)]
        $SubStatusID=$null,
        
        [Parameter(Mandatory=$false)]
        $ProjectID=$null,
        
        [Parameter(Mandatory=$false)]
        [ValidateScript({
            if ((Get-ITUser -UserID $SubmittedBy).OrganizationID -eq $_){
                $true 
            } else {
                throw "'SubmittedBy' user Organization ID does not match, or user does not have an Organization ID."    
            }
        })]
        [string]$OrganizationID=(Get-ITUser -UserID $SubmittedBy).OrganizationID,
        
        [Parameter(Mandatory=$false)]
        [ValidateSet("true","false")]
        [string]$ShouldNeverSendEmailForIssue="false",
        
        [Parameter(Mandatory=$false)]
        $ClassID=$null,
        
        [Parameter(Mandatory=$false)]
        $DepartmentID=$null,
        
        [Parameter(Mandatory=$false)]
        $SpecialFunction1=$null,
        
        [Parameter(Mandatory=$false)]
        $SpecialFunction2=$null,
        
        [Parameter(Mandatory=$false)]
        $SpecialFunction3=$null,
        
        [Parameter(Mandatory=$false)]
        $SpecialFunction4=$null,
        
        [Parameter(Mandatory=$false)]
        $SpecialFunction5=$null
    )

    $Body = @{
        ShouldSuppressEmailForCreateOperation="$ShouldSuppressEmailForCreateOperation"
        SubmittedDate=$SubmittedDate
        EnteredBy=$EnteredBy
        SeverityID=$SeverityID
        Subject=$Subject
        Description=$Description
        IsDescriptionRichText="$IsDescriptionRichText"
        IssueTypeID=$IssueTypeID
        IssueSubTypeID=$IssueSubTypeID
        IssueSubType2ID=$IssueSubType2ID
        IssueSubType3ID=$IssueSubType3ID
        IssueSubType4ID=$IssueSubType4ID
        Priority=$Priority
        AssetNumber=$AssetNumber
        LocationID=$LocationID
        SubmittedBy=$SubmittedBy
        AssignedTo=$AssignedTo
        TargetDate=$TargetDate
        RequiredByDate=$RequiredByDate
        NextActionTo=$NextActionTo
        SubStatusID=$SubStatusID
        ProjectID=$ProjectID
        OrganizationID=$OrganizationID
        ShouldNeverSendEmailForIssue="$ShouldNeverSendEmailForIssue"
        ClassID=$ClassID
        DepartmentID=$DepartmentID
        SpecialFunction1=$SpecialFunction1
        SpecialFunction2=$SpecialFunction2
        SpecialFunction3=$SpecialFunction3
        SpecialFunction4=$SpecialFunction4
        SpecialFunction5=$SpecialFunction5
    }

    $apiCall = @{
        Body = $Body
        RestMethod = "/api/v1/issues"
        Method = "POST"
    }

    $Results = Invoke-IssueTrakAPI @apiCall

    foreach ($Result in $Results) {
        [PSCustomObject]@{IssueNumber=$Result}
    }

}