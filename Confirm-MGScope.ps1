
<#
.SYNOPSIS
Automate the connection to Microsoft Graph by only making connections to scopes that have not been connected yet.

.NOTES
Created by Bernard on 1/24/2018
#>

Function Confirm-MGScope ([Array]$NeededScope) {
#   Debug-Module ("mggraph")
    [array]$scopes = (Get-MgContext).Scopes
    if($scopes.count -eq 0){Connect-MgGraph -NoWelcome
    }    
    foreach ($neededPermission in $NeededScope) {
        if ($neededPermission -notin $scopes){
            Connect-MgGraph -scope $neededPermission -NoWelcome
            Write-Host "Scope has been added - $($neededPermission)"
        }else{
            Write-Host "Scope is available $($neededPermission)"
        }
    }
}
