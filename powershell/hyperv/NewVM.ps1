param (
    [string]$computerName = 'localhost',
    [string]$VMName,
    [string]$VHDPath,
    [string]$VMSwitch,
    [string]$Memory = '1GB',
    [string]$HardDiskSize = '5GB'
    )

if (! $VHDPath) {
    $VHDPath = $VMName + ".vhdx"
}

New-VM -ComputerName $computerName -Name $VMName -MemoryStartupBytes $Memory`
    -BootDevice CD -Switchame $VMSwitch -NewVHDSizeBytes $HardDiskSize`
    -NewVHDPath $VHDPath
