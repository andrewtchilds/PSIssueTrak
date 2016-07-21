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
        [string]$SeverityID=$null,
        
        [Parameter(Mandatory=$true)]
        [string]$Subject,
        
        [Parameter(Mandatory=$true)]
        [string]$Description,
        
        [Parameter(Mandatory=$false)]
        [ValidateSet("true","false")]
        [string]$IsDescriptionRichText="true",
        
        [Parameter(Mandatory=$true)]
        [string]$IssueTypeID,
        
        [Parameter(Mandatory=$false)]
        [string]$IssueSubTypeID=0,
        
        [Parameter(Mandatory=$false)]
        [string]$IssueSubType2ID=0,
        
        [Parameter(Mandatory=$false)]
        [string]$IssueSubType3ID=0,
        
        [Parameter(Mandatory=$false)]
        [string]$IssueSubType4ID=0,
        
        [Parameter(Mandatory=$false)]
        [string]$Priority="3 - Medium",
        
        [Parameter(Mandatory=$false)]
        [string]$AssetNumber=$null,
        
        [Parameter(Mandatory=$false)]
        [string]$LocationID=$null,
        
        [Parameter(Mandatory=$true)]
        [ValidateScript({ if(Get-ITUser -UserID $_){ $true } })]
        [string]$SubmittedBy,
        
        [Parameter(Mandatory=$true)]
        [ValidateScript({ if(Get-ITUser -UserID $_){ $true } })]
        [string]$AssignedTo,
        
        [Parameter(Mandatory=$false)]
        [string]$TargetDate=$null,
        
        [Parameter(Mandatory=$false)]
        [string]$RequiredByDate=$null,
        
        [Parameter(Mandatory=$false)]
        [ValidateScript({ if(Get-ITUser -UserID $_){ $true } })]
        [string]$NextActionTo=$null,
        
        [Parameter(Mandatory=$false)]
        [string]$SubStatusID=$null,
        
        [Parameter(Mandatory=$false)]
        [string]$ProjectID=$null,
        
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
        [string]$ClassID=$null,
        
        [Parameter(Mandatory=$false)]
        [string]$DepartmentID=$null,
        
        [Parameter(Mandatory=$false)]
        [string]$SpecialFunction1=$null,
        
        [Parameter(Mandatory=$false)]
        [string]$SpecialFunction2=$null,
        
        [Parameter(Mandatory=$false)]
        [string]$SpecialFunction3=$null,
        
        [Parameter(Mandatory=$false)]
        [string]$SpecialFunction4=$null,
        
        [Parameter(Mandatory=$false)]
        [string]$SpecialFunction5=$null
    )

    #Need to make sure variables are actually null, otherwise ConvertTo-Json spits out an empty string instead of null...
    #Ugly, but works for now
    foreach($h in $MyInvocation.MyCommand.Parameters.GetEnumerator()) {
        if((Get-Variable $h.key -ErrorAction SilentlyContinue).Value -eq ""){
            Remove-Variable $h.key
        }
    }
    
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