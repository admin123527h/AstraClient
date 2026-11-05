$dir = $PSScriptRoot
$jar = Join-Path $dir 'AstraLauncher.jar'
$ico = Join-Path $dir 'astra.ico'

if (-not (Test-Path $jar)) {
    Write-Host 'AstraLauncher.jar was not found next to this script.' -ForegroundColor Red
    exit 1
}

$desktop = [Environment]::GetFolderPath('Desktop')
$shell = New-Object -ComObject WScript.Shell
$lnk = $shell.CreateShortcut((Join-Path $desktop 'Astra Client.lnk'))

$java = Get-Command javaw.exe -ErrorAction SilentlyContinue
if ($java) {
    $lnk.TargetPath = $java.Source
    $lnk.Arguments = "-jar `"$jar`""
} else {
    $lnk.TargetPath = $jar
}
$lnk.WorkingDirectory = $dir
if (Test-Path $ico) { $lnk.IconLocation = $ico }
$lnk.Description = 'Astra Client'
$lnk.Save()

Write-Host "Shortcut created on your desktop: Astra Client" -ForegroundColor Green
