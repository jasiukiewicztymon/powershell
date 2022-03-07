$num = -4;

switch ($num) { 
    {$_ -eq 1} {write-host "+1"; break}
    {$_ -eq 2} {write-host "+2"; break}
    {$_ -eq 3} {write-host "+3"; break}
    default {write-host $num; break}
}
