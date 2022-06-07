function cmdletbind {
  [cmdletbinding()]
  param([string]$name)
  BEGIN { write-host "Hello`n" -ForegroundColor green }
  PROCESS { write-host $name }
}
