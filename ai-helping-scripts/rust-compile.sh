#!/bin/bash

# Configuration
BASE_STAGING="/home/mostypc123/my_packages_uwu"
OUTPUT_DIR="/home/mostypc123/my_packages_uwu/car3-pkgs-testing"
BUILD_DIR="/tmp/rust_standalone_$(date +%s)"
NAME="rust"
VERSION="1.76.0"
URL="https://static.rust-lang.org/dist/rustc-1.76.0-src.tar.xz"

# Create directories
mkdir -p "$BASE_STAGING" "$OUTPUT_DIR" "$BUILD_DIR"
cd "$BUILD_DIR" || exit 1

echo "==========================================="
echo "STARTING STANDALONE RUST BUILD: $VERSION"
echo "==========================================="

# 1. Download
ARCHIVE=$(basename "$URL")
wget -nc "$URL"

# 2. Extract
EXTRACT_FOLDER="src_$NAME"
mkdir -p "$EXTRACT_FOLDER"
echo "Extracting... this may take a minute..."
tar -xf "$ARCHIVE" -C "$EXTRACT_FOLDER" --strip-components=1

# 3. Prepare Staging
PKG_STAGING="$BASE_STAGING/$NAME"
rm -rf "$PKG_STAGING"
mkdir -p "$PKG_STAGING"

pushd "$EXTRACT_FOLDER" > /dev/null

# 4. Configure
echo "Configuring Rust..."
./configure \
    --prefix=/usr \
    --disable-docs \
    --enable-extended \
    --release-channel=stable || exit 1

# 5. Build
# This uses the Python you just built/have on system. 
# It will use all CPU cores.
echo "Running x.py build (Grab a coffee, this takes a long time)..."
python3 x.py build --stage 2 || exit 1

# 6. Install
# We use the DESTDIR here instead of in the configure step.
echo "Installing to staging directory..."
DESTDIR="$PKG_STAGING" python3 x.py install || exit 1

# 7. Metadata
echo "version $VERSION" > "$PKG_STAGING/car"
echo "dep python" >> "$PKG_STAGING/car"
echo "dep perl" >> "$PKG_STAGING/car"

popd > /dev/null

# 8. Compress
echo "Creating final archive..."
tar -I zstd -cf "$OUTPUT_DIR/$NAME.tar.zst" -C "$BASE_STAGING" "$NAME"

# 9. Cleanup
rm -rf "$BUILD_DIR"

echo "==========================================="
echo "RUST BUILD COMPLETE"
echo "Location: $OUTPUT_DIR/$NAME.tar.zst"
echo "==========================================="
