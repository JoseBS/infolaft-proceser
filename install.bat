@echo off
echo ----------------------------------------------
echo ------------Instalando herramienta------------
echo ----------------------------------------------
set desktopFolder=%USERPROFILE%\Desktop
set desktopFolderOneDrive="%USERPROFILE%\OneDrive - Telefonica\Desktop"
set infolaftToolBat=infolaftTool.bat
set toolFolder=%~dp0
set command=.\node.exe .\index.js --nombre NOMBRE.xlsx --nombreId NOMBRE_ID.xlsx --outFile Resultados
echo ----------------------------------------------
echo ------Eliminando installaciones previas-------
echo ----------------------------------------------
del %desktopFolder%\%infolaftToolBat%
del %desktopFolderOneDrive%\%infolaftToolBat%
echo ----------------------------------------------
echo ---------------Creando archivos---------------
echo ----------------------------------------------
echo cd %toolFolder% >> %desktopFolder%\%infolaftToolBat%
echo %command% >> %desktopFolder%\%infolaftToolBat%
echo cd %toolFolder% >> %desktopFolderOneDrive%\%infolaftToolBat%
echo %command% >> %desktopFolderOneDrive%\%infolaftToolBat%
echo ----------------------------------------------
echo -------Creando carpeta de procesado-----------
echo ----------------------------------------------
cd ..
rmdir /S /Q filesToProcess
mkdir filesToProcess
echo ----------------------------------------------
echo ----------Instalacion finalizada--------------
echo ----------------------------------------------
