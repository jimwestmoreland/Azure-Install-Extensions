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
$diagnosticsconfig_path = "C:\\xmltemplate.xml"

#Specify the storage account
$storageaccount = "storageacctname"

#############################
#Import CSV Into Array
#############################
$array =Import-Csv -Path "C:\\vmstlist.csv" -Delimiter ","


$array | ForEach-Object {
    $vm_name = $_.ServerName
    $vm_resourcegroup = $_.ResourceGroup
    
    #############################
    #Get the ResourceID for the VM to update XML
    #############################
    #Get the Resource ID
    $resourceID = (get-AzureRMVM -Name $vm_name -ResourceGroupName $vm_resourcegroup | ft -Property id -HideTableHeaders | out-string).Trim()
   

    ##############################
    #Update the XML template
    ##############################
    [xml]$myXML = Get-Content $diagnosticsconfig_path
    $myXML.PublicConfig.WadCfg.DiagnosticMonitorConfiguration.Metrics.resourceid = $resourceid 
    $myxml.PublicConfig.StorageAccount = $storageaccount
    $myXML.Save("$diagnosticsconfig_path")

    Write-Host "servername is " $vm_name 
    write-Host "ResourceGroup is " $vm_resourcegroup
    Write-Host "RID is"  $resourceID

    Set-AzureRmVMDiagnosticsExtension -ResourceGroupName $vm_resourcegroup -VMName $vm_name -DiagnosticsConfigurationPath $diagnosticsconfig_path

    
   }