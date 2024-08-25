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

@set output=SUCCESS: Created pack_dev.zip at %build_path%.

@REM Create zip
tar -caf pack_dev.zip pack.png pack.mcmeta assets

@REM Move the zip to the destination. If error, log the error and delete the log file.
move pack_dev.zip %build_path% || (
    echo ERROR: Failed to move file, is it already in use?
    exit
)

echo SUCCESS: Created pack_dev.zip at %build_path%.
