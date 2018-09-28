#Inputs Needed before you start
#XML Template from Microsoft Doc
#Storage Account
#CSV file with Servername,Resourcegroup


############################
#
#Manually Set the Following Variables
#
############################

#Full Path to XML Template
$diagnosticsconfig_path = "FULL PATH TO XML\NAME OF FILE.xml"

#Specify the storage account
$storageaccount = "ENTER STORAGE ACCOUNT"

#############################
#Import CSV Into Array
#############################
$array =Import-Csv -Path "C:\users\jimwest\Desktop\vmstlist.csv" -Delimiter ","


$array | ForEach-Object {
    $vm_name = $_.ServerName
    $vm_resourcegroup = $_.ResourceGroup
    
    #############################
    #Get the ResourceID for the VM to update XML
    #############################
    #Get the Resource ID
    $resourceID = get-azurermresource -name <$vm_name> | ft -property resourceid

    ##############################
    #Update the XML template
    ##############################
    [xml]$myXML = Get-Content $diagnosticsconfig_path
    $myXML.PublicConfig.WadCfg.DiagnosticMonitorConfiguration.Metrics.resourceid = $resourceid
    $myxml.PublicConfig.StorageAccount = $storageaccount
    $myXML.Save("$diagnosticsconfig_path")
	Write-Host "servername is " $vm_resourcegroup " and ResourceGroup is " $vm_name
    Set-AzureRmVMDiagnosticsExtension -ResourceGroupName $vm_resourcegroup -VMName $vm_name -DiagnosticsConfigurationPath $diagnosticsconfig_path

   
   }