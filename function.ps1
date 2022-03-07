function func {
    param ([int]$a, [int]$b)
    "{0}" -F ($a + $b)
}

func 2 3
