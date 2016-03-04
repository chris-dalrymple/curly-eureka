#!powershell
# This file is part of Ansible
#
# Ansible is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Ansible is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Ansible.  If not, see <http://www.gnu.org/licenses/>.

# WANT_JSON
# POWERSHELL_COMMON

$params = Parse-Args $args

$name = Get-Attr $params "name" -failifempty $true
$adapter = Get-Attr $params "adapter"
$os_mgmt = Get-Attr $params "os_mgmt" $true
$state = Get-Attr $params "state" "present"

# result
$result = New-Object psobject @{
    changed = $FALSE
}

# Check that Hyper-V is installed before proceeding
If (! (Get-WindowsFeature Hyper-V))
{
    Fail-Json (New-Object psobject) "Hyper-V not detected on this system"
}

# Validate the value passed to state
$state = $state.ToString().ToLower()
If (($state -ne "present") -and ($state -ne "absent")) {
    Fail-Json (New-Object psobject) "state is '$state'; must be 'present' or 'absent'"
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
            Fail-Json (New-Object psobject) "adapter '$adapter' does not exist"
        }
    }
    Else
    {
        Fail-Json (New-Object psobject) "adapter cannot be null"
    }

    If($current_vms -notcontains $name)
    {
        New-VMSwitch -Name $name -NetAdapterName $adapter -AllowManagementOS $os_mgmt
        $result.changed = $TRUE
    }
}
Else
{
    If($current_vms -contains $name)
    {
        Remove-VMSwitch -Name $name -Force
        $result.changed = $TRUE
    }
}

Exit-Json $result
