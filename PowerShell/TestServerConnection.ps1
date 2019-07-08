# Test Connection to Servers
$computers = Get-DbaRegServer serverCMS -group active
Test-DbaConnection -SqlInstance $computers | Out-GridView
