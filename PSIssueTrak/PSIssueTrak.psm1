#Get public and private function definition files.
$Public  = Get-ChildItem $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue 
$Private = Get-ChildItem $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue 

#Dot source the files
foreach($import in @($Public + $Private)) {
    try {
        . $import.fullname
    }
    catch {
        Write-Error "Failed to import function $($import.fullname)"
    }
}

#Create / Read config
if(-not (Test-Path -Path "$PSScriptRoot\PSIssueTrak.xml" -ErrorAction SilentlyContinue)) {
    try {
        Write-Warning "Did not find config file $PSScriptRoot\PSIssueTrak.xml, attempting to create"
        [pscustomobject]@{
            Uri = $null
            APIKey = $null
        } | Export-Clixml -Path "$PSScriptRoot\PSIssueTrak.xml" -Force -ErrorAction Stop
    }
    catch {
        Write-Warning "Failed to create config file $PSScriptRoot\PSIssueTrak.xml: $_"
    }
}

#Import the config.  Clear out any legacy references to Proxy in the config file.
try {
    
    $PSIssueTrakConfig = $null
    $PSIssueTrakConfig = Get-PSIssueTrakConfig -Source "ConfigFile" -ErrorAction Stop | Select -Property *
}
catch {   
    Write-Warning "Error reading PSIssueTrak.xml: $_"
}

#Create some aliases, export public functions and the PSIssueTrakConfig variable
$PublicNames = $Public | Select -ExpandProperty BaseName

Export-ModuleMember -Function $PublicNames -Alias * -Variable PSIssueTrakConfig