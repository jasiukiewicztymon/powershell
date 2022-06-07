function printAge {
    [cmdletbinding()]param(
        [parameter (mandatory=$true)][alias ("pseudo")][string]$name,
        [alias ("ageOld")]$age = $null,
        [parameter (mandatory=$true)][validaterange (1987, 2022)]$year
    )

    if ($age -ne $null) {
        write-host "my name is $name and I'm $age old"
    }
    else {
        write-host "my name is $name, $year"
    }
}
printAge -pseudo "titi" -year 2020 17
