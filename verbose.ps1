function cmdletbind {                                                                                                                                                  in pwsh at 18:31:13
  [cmdletbinding()]
  param([string]$name)
  BEGIN {
    write-verbose "Begin of the BEGIN section"
    write-host "Hello" -ForegroundColor green
    write-verbose "End of the BEGIN section"
  }
  PROCESS { write-host $name }
}
