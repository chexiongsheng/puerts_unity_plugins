VERSION=$1

cd ~
echo "=====[ Getting Depot Tools ]====="	
git clone -q https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=$(pwd)/depot_tools:$PATH
gclient


mkdir v8
cd v8

echo "=====[ Fetching V8 ]====="
fetch v8
echo "target_os = ['ios']" >> .gclient
cd ~/v8/v8
git checkout refs/tags/$VERSION
gclient sync

cp $GITHUB_WORKSPACE/patch/8.4.371.19/bitcode/BUILD.gn third_party/inspector_protocol/

echo "=====[ Building V8 ]====="
python ./tools/dev/v8gen.py arm64.release -vv -- '
v8_enable_pointer_compression = false
is_official_build = true
use_custom_libcxx = false
is_component_build = false
symbol_level = 0
v8_enable_v8_checks = false
v8_enable_debugging_features = false
is_debug = false
v8_use_external_startup_data = false
use_xcode_clang = true
enable_ios_bitcode = true
v8_enable_i18n_support = false
target_cpu = "arm64"
v8_target_cpu = "arm64"
target_os = "ios"
ios_deployment_target = "9.0"
ios_enable_code_signing = false
'
ninja -C out.gn/arm64.release -t clean
ninja -C out.gn/arm64.release wee8

mkdir -p output/v8/Lib/iOS/bitcode
cp out.gn/arm64.release/obj/libwee8.a output/v8/Lib/iOS/bitcode/

node $GITHUB_WORKSPACE/v8-build/genBlobHeader.js "ios arm64" out.gn/arm64.release/snapshot_blob.bin
mkdir -p output/v8/Inc/Blob/iOS/arm64
cp SnapshotBlob.h output/v8/Inc/Blob/iOS/bitcode/