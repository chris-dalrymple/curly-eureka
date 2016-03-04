param (
    [string]$switchName,
    [string]$adapterName
    )

$ethernet = Get-NetAdapter -Name $adapterName

New-VMSwitch -Name $switchName -NetAdapterName $ethernet.Name -AllowManagementOS $true
