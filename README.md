# Windows

# Установить Openssh server в windows

**Get-WindowsCapability -Online | Where-Object Name -like ‘OpenSSH.Server*’ | Add-WindowsCapability –Online** 

**Set-Service -Name sshd -StartupType 'Automatic'** - включить автозапуск службы

**Start-Service sshd** - запустить службу.

**Get-NetFirewallRule -Name *OpenSSH-Server* |select Name, DisplayName, Description, Enabled** - Проверьте, правило брандмауэра, разрешающее входящие подключения по порту 22

**New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22** - создать правило если отключено.

**start-process notepad C:\Programdata\ssh\sshd_config** - открыть конфиг файл.

**shutdown /s** - выключить.

**shutdown /r** - перезагрузить
