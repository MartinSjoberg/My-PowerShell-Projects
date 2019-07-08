
$computers = Get-DbaCmsRegServer server1353 -group active
$saveTable = Find-DbaUserObject -SqlInstance $computers -Pattern ''
Write-DbaDbTableData -SqlInstance server1451 -InputObject $saveTable -Table DBA_Tools.dbo.tblDbaUserObjectOwner -Truncate


#'VT\christiancasseladmin' 
# $computers

# Test-DbaWindowsLogin -ServerInstance $computers | Out-GridView
# 
