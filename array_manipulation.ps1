$arr = "a", "b", "c", "d"

$arr += "e"
$arr[0] = "e"

$arr |Select-Object -Last 2
$arr
