Connect-VIServer 192.168.1.10 -User choongmun@sandpit.local -Password Password123!
$hostName = "192.168.1.13"
$dsName = "Range-Datastore"
$folderName = "Internz_Clients"
$SourceSpec = Get-OSCustomizationSpec -Name "IT"

$no_of_vm = 2
$SourceTemplate = Get-Template -Name "Win7Prox64Temp"
$name = "Client"
$client_no = 1

while($no_of_vm -gt 0){
    $vmname = $name + $client_no + "_Win7Prox64"
    New-VM -Name $vmname -VMHost $hostName -Template $SourceTemplate -Datastore $dsName -Location $folderName

    $startvm = Get-VM -name $vmname
    Start-VM -VM $startvm -RunAsync

    $client_no -= -1
    $no_of_vm -= 1
}

$no_of_vm = 2
$SourceTemplate = Get-Template -Name "Win10Prox64Temp"
$client_no = 3

while($no_of_vm -gt 0){
    $vmname = $name + $client_no + "_Win10Prox64"
    New-VM -Name $vmname -VMHost $hostName -Template $SourceTemplate -Datastore $dsName -Location $folderName 
    
    $startvm = Get-VM -name $vmname
    Start-VM -VM $startvm -RunAsync

    $client_no -= -1
    $no_of_vm -= 1
}

Disconnect-VIServer 192.168.1.10 -Confirm:$false