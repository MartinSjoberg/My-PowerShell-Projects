
$computers = Get-DbaCmsRegServer serverCMS -group active
$saveTable = Find-DbaUserObject -SqlInstance $computers -Pattern ''
Write-DbaDbTableData -SqlInstance serverDBALAB -InputObject $saveTable -Table DBA_Tools.dbo.tblDbaUserObjectOwner -Truncate
