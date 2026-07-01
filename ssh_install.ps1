# 1. Установка OpenSSH Сервера
Write-Host "Установка OpenSSH Server..." -ForegroundColor Cyan
Get-WindowsCapability -Online | Where-Object Name -Like 'OpenSSH.Server*' | Add-WindowsCapability -Online

# 2. Настройка и запуск службы
Write-Host "Настройка автозапуска и запуск службы sshd..." -ForegroundColor Cyan
Set-Service -Name sshd -StartupType 'Automatic'
Start-Service sshd

# 3. Настройка брандмауэра (открытие порта 22)
Write-Host "Проверка и настройка брандмауэра..." -ForegroundColor Cyan
$Rule = Get-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -ErrorAction SilentlyContinue

if ($Rule) {
    Enable-NetFirewallRule -Name 'OpenSSH-Server-In-TCP'
    Write-Host "Стандартное правило брандмауэра успешно включено." -ForegroundColor Green
} else {
    New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -Localport 22
    Write-Host "Создано новое правило брандмауэра для порта 22." -ForegroundColor Green
}

# 4. Проверка статуса службы
Write-Host "`nПроверка статуса службы SSH:" -ForegroundColor Yellow
Get-Service -Name sshd | Select-Object Name, Status, StartType

# 5. Открытие конфигурационного файла
Write-Host "`nОткрытие файла конфигурации sshd_config..." -ForegroundColor Cyan
Start-Process notepad C:\ProgramData\ssh\sshd_config

Write-Host "`nВсе готово!" -ForegroundColor Green
