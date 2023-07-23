@echo off
echo ----------------------------------------------
echo ------------Instalando herramienta------------
echo ----------------------------------------------
echo ------Antes de instalar mueva la carpeta------
echo -------------a su ubicacion final-------------
echo ----------------------------------------------
set /P isReadyToInstall=Seguro de instalar? Y/N 
IF /i %isReadyToInstall%==Y (
    goto install
)
exit
:install
echo ----------------------------------------------
echo -------Instalando dependencias de node--------
npm i
set desktopFolder=%USERPROFILE%\Desktop
set desktopFolderOneDrive="%USERPROFILE%\OneDrive - Telefonica\Desktop"
set infolaftToolBat=infolaftTool.bat
set toolFolder=%~dp0
set command=node .\index.js --nombre NOMBRE.xlsx --nombreId NOMBRE_ID.xlsx --outFile Resultados
echo ----------------------------------------------
echo ------Eliminando installaciones previas-------
del %desktopFolder%\%infolaftToolBat%
del %desktopFolderOneDrive%\%infolaftToolBat%
echo ----------------------------------------------
echo ---------------Creando archivos---------------
echo cd %toolFolder% >> %desktopFolder%\%infolaftToolBat%
echo %command% >> %desktopFolder%\%infolaftToolBat%
echo cd %toolFolder% >> %desktopFolderOneDrive%\%infolaftToolBat%
echo %command% >> %desktopFolderOneDrive%\%infolaftToolBat%
echo ----------------------------------------------
echo -------Creando carpeta de procesado-----------
cd ..
rmdir /S /Q filesToProcess
mkdir filesToProcess
echo ----------------------------------------------
echo ----------Instalacion finalizada--------------
echo ----------------------------------------------
pause
