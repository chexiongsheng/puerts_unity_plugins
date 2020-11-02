set VERSION=%1

cd %HOMEPATH%
echo =====[ Getting Depot Tools ]=====
powershell -command "Invoke-WebRequest https://storage.googleapis.com/chrome-infra/depot_tools.zip -O depot_tools.zip"
7z x depot_tools.zip -o*
set PATH=%CD%\depot_tools;%PATH%
set GYP_MSVS_VERSION=2019
set DEPOT_TOOLS_WIN_TOOLCHAIN=0
call gclient


mkdir v8
cd v8

echo =====[ Fetching V8 ]=====
call fetch v8
cd v8
call git checkout refs/tags/%VERSION%
cd test\test262\data
call git config --system core.longpaths true
call git restore *
cd ..\..\..\
call gclient sync

echo =====[ Building V8 ]=====
call gn gen out.gn\x64.release -args="target_os=""win"" target_cpu=""x64"" v8_use_external_startup_data=true v8_enable_i18n_support=false is_debug=false v8_static_library=true is_clang=false v8_enable_pointer_compression=false v8_enable_verify_heap=true dcheck_always_on=true"

call ninja -C out.gn\x64.release -t clean
call ninja -C out.gn\x64.release wee8

node %~dp0\genBlobHeader.js "window x64" out.gn\x64.release\snapshot_blob.bin

md output\v8\Lib\Win64
copy /Y out.gn\x64.release\obj\wee8.lib output\v8\Lib\Win64\
md output\v8\Inc\Blob\Win64
copy SnapshotBlob.h output\v8\Inc\Blob\Win64\
