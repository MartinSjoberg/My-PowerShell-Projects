
$computers = Get-DbaCmsRegServer  server1353 -group active 
Find-DbaUserObject -SqlInstance $computers -Pattern 'VT\bjornasmanadmin' | Out-GridView



# Get-DbaService -ComputerName $computers| Out-GridView

# Test-DbaPowerPlan -ComputerName $computers | Out-GridView
# Get-DbaCmsRegServer  server1353 -group active | ForEach-Object { [pscustomobject]@{ComputerName = $PSItem} }  | Test-DbaPowerPlan
