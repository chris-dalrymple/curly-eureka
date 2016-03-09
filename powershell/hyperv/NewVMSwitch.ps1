param (
    [string]$name = $(throw "-name is required."),
    [string]$state = "present",
    [string]$adapter,
    [boolean]$os_mgmt = $true
)

# Check that Hyper-V is installed before proceeding
If (! (Get-WindowsFeature Hyper-V))
{
    Write-Host "Hyper-V not detected on this system"
    Exit 1
}

# Validate the value passed to state
$state = $state.ToString().ToLower()
If (($state -ne "present") -and ($state -ne "absent")) {
    Write-Host "state is '$state'; must be 'present' or 'absent'"
    Exit 1
}

# Get a list of the currently existing VMSwitches
[string[]]$current_vms = Get-VMSwitch | foreach { $_.Name }

If ( $state -eq "present" )
{
    # Validate that the adapter var is not empty
    If ($adapter -ne $null)
    {
        $adapter = $adapter.ToString()
        # Get a list of the network adapters and check that the network adapter exists
        [string[]]$current_adapters = Get-NetAdapter | foreach { $_.Name }
        If ($current_adapters -notcontains $adapter)
        {
            Write-Host "adapter '$adapter' does not exist"
            Exit 1
        }
    }
    Else
    {
        Write-Host "adapter cannot be null"
        Exit 1
    }

    If($current_vms -notcontains $name)
    {
        New-VMSwitch -Name $name -NetAdapterName $adapter -AllowManagementOS $os_mgmt
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
