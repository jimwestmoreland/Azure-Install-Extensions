
 $diagnosticsconfig_path = "C:\users\jimwest\Desktop\xmltemplate.xml"
 $storageaccount = "jimweststorageaccount"
 $resourceid = "&#xD;&#xA;resourceID;&#xD;&#xA;&#xD;&#xA;" 
 $resourceid2 = "ResourceID2"
 #$resourceid -replace "&#xD;","" -replace "&#xA","" -replace ";",""

 
  [xml]$myXML = Get-Content $diagnosticsconfig_path
    $myXML.PublicConfig.WadCfg.DiagnosticMonitorConfiguration.Metrics.resourceid = $resourceid #.Trim("&#xD")
    $myxml.PublicConfig.StorageAccount = $storageaccount 
    $myxml.PublicConfig.WadCfg.DiagnosticMonitorConfiguration.Metrics.resourceId.ToString
    #-replace "&amp;","" -replace "#xD;","" -replace "#xA;",""
    
    $myXML.Save("$diagnosticsconfig_path")