# Test Connection to SErvers
$computers = Get-DbaCmsRegServer serverCMS -group active
Test-DbaConnection -SqlInstance $computers | Out-GridView
