#--- WSL 2 + current Ubuntu LTS (safe to re-run) ---
choco install -y Microsoft-Windows-Subsystem-Linux --source="'windowsfeatures'"
choco install -y VirtualMachinePlatform --source="'windowsfeatures'"
if (Test-PendingReboot) { Invoke-Reboot }

wsl --update
wsl --set-default-version 2

# wsl.exe prints UTF-16 by default, which breaks string comparison
$env:WSL_UTF8 = 1
if ((wsl --list --quiet) -notcontains "Ubuntu") {
    # --no-launch: first start of "Ubuntu" asks for your Linux user, then run: sudo apt update && sudo apt upgrade -y
    wsl --install --distribution Ubuntu --no-launch
} else {
    Write-Host "Ubuntu already installed, skipping"
}
