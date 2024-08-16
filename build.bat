@REM Packs the resources and moves it to the folder specified in in build_path.txt
@REM Even works without unloading the resource pack; simple use F3 + T in game to refresh the pack.
@REM build_path.txt should the path to you resource packs folder on the first line in double quotes.
@REM e.g. "C:\Users\name\AppData\Roaming\.minecraft\resourcepacks"

@echo off

@REM Create build_path.txt if not exists
if not exist build_path.txt (
    @REM copy NUL build_path.txt
    echo your_path_here> build_path.txt
)

@REM Set path variable
set /p build_path=< build_path.txt

@REM If path empty or doesn't exist, exit
if [%build_path%] == [] goto:error
if not exist %build_path% goto:error
goto:eoerr

:err
    echo ERROR: %build_path% is not a valid path.
    echo Please enter the correct path in double quotes on the first line of build_path.txt.
    echo e.g. "C:\Users\name\AppData\Roaming\.minecraft\resourcepacks"
    exit
:eoerr

@REM Create zip and move it to the destination
tar -caf pack_dev.zip pack.png pack.mcmeta assets
move pack_dev.zip %build_path%

echo SUCCESS: Created pack_dev.zip at %build_path%.
