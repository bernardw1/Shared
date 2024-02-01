
<#
.SYNOPSIS
Check for installed modules and install them
.DESCRIPTION
This is a function that allows checking of the modules that are installed. If the module is not installed then it will attempt to install it

.PARAMETER mod
Pass the module name to check to see if it is installed

.EXAMPLE
checkmodlue ('AzureAD')

.NOTES
created 7/25/2017
#>
Function Debug-Module ($mod)
{
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

    #Check if module is installed
    if(-not(Get-Module -name $mod))
    {
        write-progress -Status "Getting all the pieces ready to start working" -activity "loading the $mod module" -Id 50
        if(Get-Module -ListAvailable | Where-Object { $_.name -eq $mod })
        {
            Import-Module -Name $mod -Global
        } #end if module available then import
        else
        {
            Write-Warning -Message "Please install the $mod module. This will be attempted now."

            Install-module -name $mod -Scope CurrentUser -confirm:$False -Repository psgallery -AllowClobber -force
            #$arg = "&{Install-module -name $mod -Scope allusers -confirm:$False -Repository psgallery -AllowClobber -force}"
            #start-process powershell.exe -Verb runas -ArgumentList "-noprofile", "-command $arg" -WindowStyle Hidden
            if(Get-Module -ListAvailable | Where-Object { $_.name -eq $mod })
            {
                Import-Module -Name $mod -Global
                Write-progress -Status 'The module has now been installed correctly' -Id 50
            } #end if module available then import
        } #module not available
    } # end if not module
}
