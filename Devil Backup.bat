@echo off
set source="D:\Testordner"
set target="H:\Databackup-server"

:Menu
cls
title Devil Backup
echo What should be done?
set /p Input=Enter Command:
if /I "%Input%"=="Create" goto Create
if /I "%Input%"=="Load" goto Load
if /I "%Input%"=="Help" goto help
if /I "%INPUT%"=="List" goto List
if /I "%INPUT%"=="Exit" exit
goto Menu

:Create
title Devil Backup --- Copying Files
mkdir %target%\temp\Data
xcopy /s /i %source% %target%"\temp\Data"

title Devil Backup --- Creating Zip
chdir /d %target%\temp\
start /wait D:\Programme\"7 Zip"\7z.exe a -r Backup.zip %target%\temp\Data

title Devil Backup --- finishing
mkdir %target%\backups\"%date%
move %target%\temp\Backup.zip %target%\backups\"%date%
chdir /d %target%
rmdir %target%\temp /S /Q
goto Menu

:Load
title Devil Backup --- selecting Backup
echo Which backup should be loaded?
set /p Input=Enter:

title Devil Backup --- duplicating Backup
mkdir %target%\temp
xcopy /s /i "%target%\backups\%Input%" "%target%\temp"

title Devil Backup --- unpacking data
chdir /d %target%\temp
start /wait D:\Programme\"7 Zip"\7z.exe x Backup.zip

title Devil Backup --- restoring Files
xcopy /s /i /Y "%target%\temp\Data" "%source%"
chdir /d %target%
rmdir %target%\temp /S /Q
goto Menu

:List
chdir /d %target%\backups
for /d /R %%D in (*) do echo %%~nxD
pause
goto Menu

:help
title Devil Backup --- Help
echo Commands:
echo           -Create
echo           -Load
echo           -List
echo           -Exit
pause
goto Menu

//Created by Racer0815