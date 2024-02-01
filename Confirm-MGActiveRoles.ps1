<#
.SYNOPSIS
function to check if a PIM role is currently assigned for the current user.

This is a great check to use for scripts that use Mircrosoft Graph in PIM environments so that the script can error out before trying to run commands

.NOTES
Created by Bernard on 2/1/2024
#>


Function Confirm-MGActiveRoles ($RoleName){

    #Make sure that there is a connection Microsoft Graph
    Connect-MgGraph -UseDeviceAuthentication -NoWelcome
    
    #Get the current user
    $context = Get-MgContext
    $currentUser = (Get-MgUser -UserId $context.Account).Id

    #Get current active roles
    $CurrentRoles = Get-MgRoleManagementDirectoryRoleAssignment -Filter "principalId eq '$currentUser'" -ExpandProperty roledefinition

    $isactive = 0

    #check if role of interest is in the list of active roles
    ForEach ($CurrentRole in $CurrentRoles){
        if ($currentrole.RoleDefinition.DisplayName -eq "'$rolename'"){
            $isactive ++
        }

    }
    #return true or false as to if the role is active
    if ($isactive -gt 0){
        Write-Output "1"
    }else{
        Write-Output "0"
    }
}

#This script could be updated to automatically request role elevation by using some information found here https://gist.github.com/arjancornelissen/ba48ced0fdcb310c9e44a4308299b63c
