#!/bin/bash

# Configuration
BASE_STAGING="/home/mostypc123/my_packages_uwu"
OUTPUT_DIR="/home/mostypc123/my_packages_uwu/car3-pkgs-testing"
BUILD_DIR="/tmp/gnu_build_$(date +%s)"

# Create directories
mkdir -p "$BASE_STAGING" "$OUTPUT_DIR" "$BUILD_DIR"

# Array: "Name|Version|URL|Dependencies"
PACKAGES=(
    "glibc|2.39|https://ftp.gnu.org/gnu/glibc/glibc-2.39.tar.xz|"
    "perl|5.38.2|https://www.cpan.org/src/5.0/perl-5.38.2.tar.gz|"
    "python|3.12.2|https://www.python.org/ftp/python/3.12.2/Python-3.12.2.tar.xz|zlib expat libffi"
    "glib|2.78.4|https://download.gnome.org/sources/glib/2.78/glib-2.78.4.tar.xz|pcre2 libffi"
    "rust|1.76.0|https://static.rust-lang.org/dist/rustc-1.76.0-src.tar.xz|python"
)

cd "$BUILD_DIR" || exit 1

for pkg in "${PACKAGES[@]}"; do
    [[ "$pkg" =~ ^# ]] && continue
    IFS="|" read -r NAME VERSION URL DEPS <<< "$pkg"
    
    echo "==========================================="
    echo "STARTING HEAVY BUILD: $NAME $VERSION"
    echo "==========================================="
    
    ARCHIVE=$(basename "$URL")
    [ ! -f "$ARCHIVE" ] && wget -nc "$URL" || echo "Archive already exists."
    
    EXTRACT_FOLDER="src_$NAME"
    mkdir -p "$EXTRACT_FOLDER"
    
    # Extraction (If this fails, skip to next)
    tar -xf "$ARCHIVE" -C "$EXTRACT_FOLDER" --strip-components=1 || { echo "Failed to extract $NAME"; continue; }
    
    PKG_STAGING="$BASE_STAGING/$NAME"
    rm -rf "$PKG_STAGING"
    mkdir -p "$PKG_STAGING"

    pushd "$EXTRACT_FOLDER" > /dev/null
    
    # Custom Configure logic
    if [[ "$NAME" == "perl" ]]; then
        sh Configure -des -Dprefix=/usr -Dinstallstyle='lib/perl5' -Ddestdir="$PKG_STAGING" || { popd; continue; }
    elif [[ "$NAME" == "glibc" ]]; then
        # Glibc requires a separate build directory
        mkdir -p build && cd build
        ../configure --prefix=/usr || { cd ..; popd; continue; }
    else
        ./configure --prefix=/usr DESTDIR="$PKG_STAGING" || { popd; continue; }
    fi
    
    # Compilation & Installation
    # The "|| { popd; continue; }" ensures we move to the next package on error
    make -j$(nproc) || { echo "Build failed for $NAME"; popd; continue; }
    make install DESTDIR="$PKG_STAGING" || { echo "Install failed for $NAME"; popd; continue; }
    
    # Metadata
    METADATA_FILE="$PKG_STAGING/car"
    { echo "version $VERSION"; [ -n "$DEPS" ] && for dep in $DEPS; do echo "dep $dep"; done; } > "$METADATA_FILE"
    
    popd > /dev/null

    # Package (Only if the folder actually has files)
    if [ -d "$PKG_STAGING" ]; then
        tar -I zstd -cf "$OUTPUT_DIR/$NAME.tar.zst" -C "$BASE_STAGING" "$NAME"
    fi

    rm -rf "$EXTRACT_FOLDER"
    echo "COMPLETED: $NAME"
done

echo "Script finished. Check $OUTPUT_DIR for results and console output for any failures."
