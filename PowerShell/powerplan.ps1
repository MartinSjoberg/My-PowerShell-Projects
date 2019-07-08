
$computers = Get-DbaRegServer  serverCMS -group active 
Test-DbaPowerPlan -ComputerName $computers | Out-GridView

# Get What sql related services are running... make it into another file
# Get-DbaService -ComputerName $computers| Out-GridView

# Alternative way
# Get-DbaRegServer serverCMS -group active | ForEach-Object { [pscustomobject]@{ComputerName = $PSItem} }  | Test-DbaPowerPlan
