param (
    [string]$name = $(throw "-name is required."),
    [string]$state = 'present',
    [string]$disk_path,
    [string]$switch,
    [string]$mem_size = '1GB',
    [string]$disk_size = '5GB'
    )

    # Check that Hyper-V is installed before proceeding
    If (! (Get-WindowsFeature Hyper-V))
    {
        Write-Host "Hyper-V not detected on this system"
        Exit 1
    }

    # TODO: There are more states for VMs than present or absent. Add support for them.
    # Validate the value passed to state
    $state = $state.ToString().ToLower()
    If (($state -ne "present") -and ($state -ne "absent")) {
        Write-Host "state is '$state'; must be 'present' or 'absent'"
        Exit 1
    }

    # Get a list of the currently existing virtual machines
    [string[]]$current_vms = Get-VM | foreach { $_.Name }

    If ( $state -eq "present" )
    {
        # Validate that the switch var is not empty
        If ($switch -ne $null)
        {
            $switch = $switch.ToString()
            # Get a list of the network switches and check that the network switch exists
            [string[]]$current_switches = Get-Netswitch | foreach { $_.Name }
            If ($current_switches -notcontains $switch)
            {
                Write-Host "switch '$switch' does not exist"
                Exit 1
            }
        }
        Else
        {
            Write-Host "switch cannot be null"
            Exit 1
        }

        If($current_vms -notcontains $name)
        {
            New-VM -Name $name -MemoryStartupBytes $mem_size -BootDevice CD`
              -Switchame $switch -NewVHDSizeBytes $disk_size`
              -NewVHDPath $disk_path
            Exit 0
        }
    }
    Else
    {
        If($current_vms -contains $name)
        {
            Remove-VMSwitch -Name $name -Force
            Exit 0
        }
    }

    Exit 1
