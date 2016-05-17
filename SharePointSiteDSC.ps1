﻿Param (
    [Parameter(Mandatory=$true)] [ValidateNotNullorEmpty()] [string] $SiteUrl,
    [Parameter(Mandatory=$true)] [ValidateNotNullorEmpty()] [string] $DataFile
)

Add-PSSnapin "Microsoft.SharePoint.PowerShell"

Import-Module .\SharePointSiteDSC.psm1 -Force
Import-Module $DataFile -Force 

$site = Get-SPSite -Identity $SiteUrl
$web = $site.OpenWeb()

if($config -ne $null){
    try{
        Start-IABuilder -web $web -config $config
    }catch [Exception]{
        Write-Warning "Error Occurred" 
        echo $_.Exception|format-list -force
    }    
}

$web.Dispose();
$site.Dispose();

# http://teams.sp2013.gt.local/sites/SharePointSiteDSC
# .\SharePointTeamSiteConfig.psm1