param(
    [string]$defaultUrl = "https://example.com",
    [int]$Repeat = 5
)
Write-Host "Usage: latency_test.ps1 [url] [repeats]"
Write-Host "`n--- Connection Latency Test ---" -ForegroundColor Cyan
Write-Host "Target: $defaultUrl"
Write-Host "Running $Repeat sequential requests...`n"

function Test-Request {
    param($Url)

    $dnsStart = Get-Date
    $hostName = ([uri]$Url).Host
    [System.Net.Dns]::GetHostAddresses($hostName) | Out-Null
    $dnsTime = (Get-Date) - $dnsStart

    $tcpStart = Get-Date
    $tcp = New-Object System.Net.Sockets.TcpClient
    $tcp.Connect($hostName, 443)
    $tcpTime = (Get-Date) - $tcpStart
    $tcp.Close()

    $httpStart = Get-Date
    try {
        $response = Invoke-WebRequest -Uri $Url -Method GET -UseBasicParsing -TimeoutSec 120
        $status = $response.StatusCode
    } catch {
        $status = $_.Exception.Message
    }
    $httpTime = (Get-Date) - $httpStart

    return [PSCustomObject]@{
        DNS_ms  = [math]::Round($dnsTime.TotalMilliseconds,2)
        TCP_ms  = [math]::Round($tcpTime.TotalMilliseconds,2)
        HTTP_ms = [math]::Round($httpTime.TotalMilliseconds,2)
        Status  = $status
    }
}

$results = @()

for ($i = 1; $i -le $Repeat; $i++) {
    Write-Host "Request #$i..." -ForegroundColor Yellow
    $result = Test-Request -Url $defaultUrl
    $results += $result
    Start-Sleep -Seconds 2
}

Write-Host "`n--- Results ---" -ForegroundColor Green
$results | Format-Table -AutoSize
