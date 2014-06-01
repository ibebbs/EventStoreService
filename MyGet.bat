@echo Off
set config=%1
if "%config%" == "" (
   set config=Release
)

set version=
if not "%PackageVersion%" == "" (
   set version=-Version %PackageVersion%
)

REM Package restore
.\src\.nuget\nuget.exe restore .\src\EventStoreService.sln -OutputDirectory %cd%\packages -NonInteractive

REM Build
%WINDIR%\Microsoft.NET\Framework\v4.0.30319\msbuild .\src\EventStoreService.sln /p:Configuration="%config%" /m /v:M /fl /flp:LogFile=msbuild.log;Verbosity=Normal /nr:false

REM Package
.\src\.nuget\nuget.exe pack .\src\EventStoreService.nuspec -BasePath .\src\deploy -OutputDirectory .\src\service