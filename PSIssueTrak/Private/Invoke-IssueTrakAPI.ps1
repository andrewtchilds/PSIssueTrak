function Invoke-IssueTrakAPI {
    <#
    .Synopsis
    An internal function that is responsbile for invoking various IssueTrak REST methods.

    .Parameter Headers
    A HashTable of the HTTP request headers as key-value pairs.

    .Parameter Method
    The HTTP method that will be used for the request.

    .Parameter RestMethod
    This parameter is a mandatory parameter that specifies the URL part, after the API's DNS name, that will be invoked.
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [HashTable] $Headers = @{ },
        [Parameter(Mandatory = $false)]
        [string] $Method = 'Get',
        [Parameter(Mandatory = $true)]
        [string] $RestMethod,
        [Parameter(Mandatory = $false)]
        [hashtable] $Body
    )

    $GUID = (New-Guid).Guid
    $Timestamp = [datetime]::UtcNow.ToString("O")

    $messageToBeHashed="$Method`n"
    $messageToBeHashed+="$GUID`n"
    $messageToBeHashed+="$Timestamp`n"
    $messageToBeHashed+="$RestMethod`n"
    $messageToBeHashed+="`n"
    if($Body){
        $messageToBeHashed+=(ConvertTo-Json $Body)
    }

    $AuthHash = Get-HMACHash -APIKey $PSIssueTrakConfig.APIKey -messageToBeHashed $messageToBeHashed

    
    $Headers.Add("X-Issuetrak-API-Request-ID", $GUID)
    $Headers.Add("X-Issuetrak-API-Timestamp", $Timestamp)
    $Headers.Add("X-Issuetrak-API-Authorization", $AuthHash)

    Write-Verbose -Message ('Headers are: {0}' -f $Headers)
    

    $ApiRequest = @{
        Headers = $Headers
        Uri = '{0}/{1}' -f $PSIssueTrakConfig.Uri,$RestMethod
        Method = $Method
    }

    if ($Body){
        $ApiRequest.Body = (ConvertTo-Json $Body)
        $ApiRequest.ContentType = "application/json"
    }

    Write-Verbose -Message ('Invoking the REST method: {0}' -f $ApiRequest.Uri)

    Invoke-RestMethod @ApiRequest
}
