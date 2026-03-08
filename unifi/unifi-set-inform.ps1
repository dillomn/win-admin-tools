# =============================================================
# Unifi WAP Bulk set-inform Script
# SSH into each Unifi Device and run mca-cli-op set-inform
# Requires: plink.exe in the same folder as this script
# =============================================================

# ---------- CONFIGURATION - EDIT THESE ----------
$informUrl = "YOUR_URL_HERE"
$sshUser   = "ubnt"
$sshPass   = "ubnt"
# ------------------------------------------------

Write-Host ""
Write-Host ""
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "	  UniFi Bulk set-inform Tool" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""

# Find plink.exe next to this script
$scriptDir = Split-Path -Parent $PSCommandPath
$plink     = Join-Path $scriptDir "plink.exe"

if (-not (Test-Path $plink)) {
    Write-Host "ERROR: plink.exe not found." -ForegroundColor Red
    Write-Host "Place plink.exe in the same folder as this script:" -ForegroundColor Yellow
    Write-Host "  $scriptDir" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Download from: https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html" -ForegroundColor Yellow
    Write-Host ""
    pause
    exit
}

Write-Host "Controller URL : $informUrl" -ForegroundColor DarkCyan
Write-Host "plink.exe      : $plink" -ForegroundColor DarkCyan
Write-Host ""
Write-Host "Enter Unifi Device IP addresses one per line."
Write-Host "Press Enter on a blank line when done."
Write-Host ""

# Collect IPs
$ipList = @()
while ($true) {
    $entry = Read-Host "  Device IP"
    if ($entry -eq "") { break }
    if ($entry -match '^\d{1,3}(\.\d{1,3}){3}$') {
        $ipList += $entry
        Write-Host "    -> Added $entry" -ForegroundColor Green
    } else {
        Write-Host "    -> Skipped (not a valid IP): $entry" -ForegroundColor Yellow
    }
}

if ($ipList.Count -eq 0) {
    Write-Host ""
    Write-Host "No IPs entered. Exiting." -ForegroundColor Red
    Write-Host ""
    pause
    exit
}

Write-Host ""
Write-Host "Processing $($ipList.Count) device(s)..." -ForegroundColor Cyan
Write-Host ""

$results = @()

foreach ($ip in $ipList) {
    Write-Host "--- $ip ---" -ForegroundColor White

    $output   = (cmd /c "echo y | `"$plink`" -ssh -l $sshUser -pw $sshPass $ip `"mca-cli-op set-inform $informUrl`"") 2>&1
    $exitCode = $LASTEXITCODE

    if ($exitCode -eq 0 -or "$output" -match "Adoptable|set-inform|OK") {
        Write-Host "  SUCCESS" -ForegroundColor Green
        $results += [PSCustomObject]@{ IP=$ip; Result="SUCCESS"; Detail="$output" }
    } else {
        Write-Host "  FAILED (exit $exitCode)" -ForegroundColor Red
        Write-Host "  $output" -ForegroundColor DarkGray
        $results += [PSCustomObject]@{ IP=$ip; Result="FAILED"; Detail="$output" }
    }
}

Write-Host ""
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "   Summary" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan
$results | Format-Table -AutoSize

$ok   = ($results | Where-Object Result -eq "SUCCESS").Count
$fail = ($results | Where-Object Result -eq "FAILED").Count
Write-Host "Total: $($results.Count)   Success: $ok   Failed: $fail" -ForegroundColor Cyan
Write-Host ""
pause
