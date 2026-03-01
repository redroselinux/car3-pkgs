#!/bin/bash

# Configuration
BASE_STAGING="/home/mostypc123/my_packages_uwu"
OUTPUT_DIR="/home/mostypc123/my_packages_uwu/car3-pkgs-testing"
BUILD_DIR="/tmp/gnu_build_$(date +%s)"

# Create directories
mkdir -p "$BASE_STAGING" "$OUTPUT_DIR" "$BUILD_DIR"

# Array: "Name|Version|URL|Dependencies"
PACKAGES=(
    # --- HISTORY: Completed Packages (Commented Out) ---
    # "readline|5.0.5|https://ftp.gnu.org/gnu/bash/readline-5.0.5.tar.gz|"
    # "groff|1.23.0|https://ftp.gnu.org/gnu/groff/groff-1.23.0.tar.gz|"
    # "bison|3.8|https://ftp.gnu.org/gnu/bison/bison-3.8.tar.xz|"
    # "binutils|2.46.0|https://ftp.gnu.org/gnu/binutils/binutils-2.46.0.tar.zst|"
    # "bash|5.3|https://ftp.gnu.org/gnu/bash/bash-5.3.tar.gz|readline"
    # "less|692|https://ftp.gnu.org/gnu/less/less-692.tar.gz|"
    # "m4|1.4.19|https://ftp.gnu.org/gnu/m4/m4-latest.tar.xz|"
    # "libsigsegv|2.15|https://ftp.gnu.org/gnu/libsigsegv/libsigsegv-2.15.tar.gz|"
    # "sed|4.9|https://ftp.gnu.org/gnu/sed/sed-4.9.tar.xz|"
    # "which|2.23|https://ftp.gnu.org/gnu/which/which-2.23.tar.gz|"
    # "xorriso|1.5.6|https://ftp.gnu.org/gnu/xorriso/xorriso-1.5.6.tar.gz|"
    # "parted|3.6|https://ftp.gnu.org/gnu/parted/parted-3.6.tar.xz|"
    # "ncurses|6.6|https://ftp.gnu.org/gnu/ncurses/ncurses-6.6.tar.gz|"
    # "nano|8.7|https://ftp.gnu.org/gnu/nano/nano-8.7.tar.xz|ncurses"
    # "tack|1.10|https://ftp.gnu.org/gnu/ncurses/tack-1.10.tar.gz|ncurses"
    # "wget2|2.2.1|https://ftp.gnu.org/gnu/wget/wget2-2.2.1.tar.lz|"
    # "mpfr|4.2.2|https://ftp.gnu.org/gnu/mpfr/mpfr-4.2.2.zip|"
    # "mpc|1.3.1|https://ftp.gnu.org/gnu/mpc/mpc-1.3.1.tar.gz|mpfr"
    # "hello|2.12|https://ftp.gnu.org/gnu/hello/hello-2.12.tar.gz|"
    # "grep|3.12|https://ftp.gnu.org/gnu/grep/grep-3.12.tar.xz|"
    # "bool|0.2.2|https://ftp.gnu.org/gnu/bool/bool-0.2.2.tar.xz|"
    # "coreutils|9.5|https://ftp.gnu.org/gnu/coreutils/coreutils-9.5.tar.xz|"
    # "patch|2.7.6|https://ftp.gnu.org/gnu/patch/patch-2.7.6.tar.xz|"
    # "tar|1.35|https://ftp.gnu.org/gnu/tar/tar-1.35.tar.xz|"
    # "diffutils|3.10|https://ftp.gnu.org/gnu/diffutils/diffutils-3.10.tar.xz|"
    # "findutils|4.10.0|https://ftp.gnu.org/gnu/findutils/findutils-4.10.0.tar.xz|"
    # "gzip|1.13|https://ftp.gnu.org/gnu/gzip/gzip-1.13.tar.xz|"
    # "gmp|6.3.0|https://ftp.gnu.org/gnu/gmp/gmp-6.3.0.tar.xz|"
    # "zlib|1.3.1|https://zlib.net/zlib-1.3.1.tar.gz|"
    # "gettext|0.22.5|https://ftp.gnu.org/gnu/gettext/gettext-0.22.5.tar.xz|"
    # "texinfo|7.1|https://ftp.gnu.org/gnu/texinfo/texinfo-7.1.tar.xz|"
    # "flex|2.6.4|https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz|"
    # "gperf|3.1|https://ftp.gnu.org/gnu/gperf/gperf-3.1.tar.gz|"
    # "expat|2.6.2|https://github.com/libexpat/libexpat/releases/download/R_2_6_2/expat-2.6.2.tar.xz|"
    # "bc|1.07.1|https://ftp.gnu.org/gnu/bc/bc-1.07.1.tar.gz|"
    # "ed|1.20.1|https://ftp.gnu.org/gnu/ed/ed-1.20.1.tar.lz|"
    # "help2man|1.49.3|https://ftp.gnu.org/gnu/help2man/help2man-1.49.3.tar.xz|"
    # "libtool|2.4.7|https://ftp.gnu.org/gnu/libtool/libtool-2.4.7.tar.gz|"
    # "pkg-config|0.29.2|https://pkgconfig.freedesktop.org/releases/pkg-config-0.29.2.tar.gz|"
    # "libidn2|2.3.7|https://ftp.gnu.org/gnu/libidn/libidn2-2.3.7.tar.gz|"
    # "gnutls|3.8.3|https://www.gnupg.org/ftp/gcrypt/gnutls/v3.8/gnutls-3.8.3.tar.xz|libidn2"
    # "cpio|2.15|https://ftp.gnu.org/gnu/cpio/cpio-2.15.tar.bz2|"
    # "indent|2.2.13|https://ftp.gnu.org/gnu/indent/indent-2.2.13.tar.gz|"
    # "units|2.23|https://ftp.gnu.org/gnu/units/units-2.23.tar.gz|"
    # "time|1.9|https://ftp.gnu.org/gnu/time/time-1.9.tar.gz|"
    # "sharutils|4.15.2|https://ftp.gnu.org/gnu/sharutils/sharutils-4.15.2.tar.xz|"
    # "unrtf|0.21.10|https://ftp.gnu.org/gnu/unrtf/unrtf-0.21.10.tar.gz|"
    # "doschars|1.0.3|https://ftp.gnu.org/gnu/doschars/doschars-1.0.3.tar.gz|"
    # "libiconv|1.17|https://ftp.gnu.org/gnu/libiconv/libiconv-1.17.tar.gz|"
    # "libunistring|1.2|https://ftp.gnu.org/gnu/libunistring/libunistring-1.2.tar.gz|"
    # "libpng|1.6.40|https://downloads.sourceforge.net/libpng/libpng-1.6.40.tar.xz|zlib"
    # "libjpeg-turbo|3.0.1|https://downloads.sourceforge.net/libjpeg-turbo/libjpeg-turbo-3.0.1.tar.gz|"
    # "popt|1.19|https://ftp.osuosl.org/pub/blfs/conglomeration/popt/popt-1.19.tar.gz|"
    # "libpipeline|1.5.7|https://download.savannah.gnu.org/releases/libpipeline/libpipeline-1.5.7.tar.gz|"
    # "file|5.45|https://astron.com/pub/file/file-5.45.tar.gz|"
    # "attr|2.5.2|https://download.savannah.gnu.org/releases/attr/attr-2.5.2.tar.gz|"
    # "acl|2.3.2|https://download.savannah.gnu.org/releases/acl/acl-2.3.2.tar.gz|attr"
    # "libcap|2.70|https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.70.tar.xz|"
    # "xz|5.6.0|https://github.com/tukaani-project/xz/releases/download/v5.6.0/xz-5.6.0.tar.xz|"
    # "kmod|32|https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-32.tar.xz|"
    # "libelf|0.191|https://sourceware.org/pub/elfutils/0.191/elfutils-0.191.tar.bz2|"
    # "libffi|3.4.6|https://github.com/libffi/libffi/releases/download/v3.4.6/libffi-3.4.6.tar.gz|"
    # "pcre2|10.43|https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.43/pcre2-10.43.tar.bz2|"
    # "util-linux|2.40|https://www.kernel.org/pub/linux/utils/util-linux/v2.40/util-linux-2.40.tar.xz|"
    # "e2fsprogs|1.47.0|https://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v1.47.0/e2fsprogs-1.47.0.tar.gz|"
    # "procps-ng|4.0.4|https://gitlab.com/procps-ng/procps/-/archive/v4.0.4/procps-v4.0.4.tar.gz|ncurses"
    # "psmisc|23.7|https://downloads.sourceforge.net/project/psmisc/psmisc/psmisc-23.7.tar.xz|ncurses"
    # "sysklogd|2.5.2|https://github.com/troglobit/sysklogd/releases/download/v2.5.2/sysklogd-2.5.2.tar.gz|"
    # "libseccomp|2.5.5|https://github.com/seccomp/libseccomp/releases/download/v2.5.5/libseccomp-2.5.5.tar.gz|"
    # "gdbm|1.23|https://ftp.gnu.org/gnu/gdbm/gdbm-1.23.tar.gz|"
    # "readline-new|8.2|https://ftp.gnu.org/gnu/readline/readline-8.2.tar.gz|"
    # "zstd|1.5.6|https://github.com/facebook/zstd/releases/download/v1.5.6/zstd-1.5.6.tar.gz|"
    # "lz4|1.9.4|https://github.com/lz4/lz4/archive/refs/tags/v1.9.4.tar.gz|"
    # "python|3.12.2|https://www.python.org/ftp/python/3.12.2/Python-3.12.2.tar.xz|zlib expat libffi"

    # --- CURRENT BATCH: Small & Reliable ---
    "libevent|2.1.12|https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz|"
    "libev|4.33|http://dist.schmorp.de/libev/libev-4.33.tar.gz|"
    "popt|1.19|https://ftp.osuosl.org/pub/blfs/conglomeration/popt/popt-1.19.tar.gz|"
    "libgpg-error|1.48|https://gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.48.tar.bz2|"
    "libgcrypt|1.10.3|https://gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.10.3.tar.bz2|libgpg-error"
    "libassuan|2.5.6|https://gnupg.org/ftp/gcrypt/libassuan/libassuan-2.5.6.tar.bz2|libgpg-error"
    "libksba|1.6.5|https://gnupg.org/ftp/gcrypt/libksba/libksba-1.6.5.tar.bz2|libgpg-error"
    "npth|1.6|https://gnupg.org/ftp/gcrypt/npth/npth-1.6.tar.bz2|"
    "libarchive|3.7.2|https://github.com/libarchive/libarchive/releases/download/v3.7.2/libarchive-3.7.2.tar.gz|"
)

cd "$BUILD_DIR" || exit 1

for pkg in "${PACKAGES[@]}"; do
    [[ "$pkg" =~ ^# ]] && continue
    IFS="|" read -r NAME VERSION URL DEPS <<< "$pkg"

    echo "==========================================="
    echo "STARTING: $NAME $VERSION"
    echo "==========================================="

    ARCHIVE=$(basename "$URL")
    [ ! -f "$ARCHIVE" ] && wget --no-check-certificate -nc "$URL"
    EXTRACT_FOLDER="src_$NAME"
    mkdir -p "$EXTRACT_FOLDER"

    tar -xf "$ARCHIVE" -C "$EXTRACT_FOLDER" --strip-components=1

    PKG_STAGING="$BASE_STAGING/$NAME"
    rm -rf "$PKG_STAGING"
    mkdir -p "$PKG_STAGING"

    pushd "$EXTRACT_FOLDER" > /dev/null

    # Improved Build Logic
    if [ -f "./configure" ]; then
        ./configure --prefix=/usr DESTDIR="$PKG_STAGING"
    elif [ -f "./autogen.sh" ] && command -v autoconf >/dev/null; then
        sh autogen.sh --prefix=/usr
        ./configure --prefix=/usr DESTDIR="$PKG_STAGING"
    else
        # Fallback for simple Makefiles (like libcap or zstd)
        echo "No configure found, attempting direct make..."
    fi

    make -j$(nproc)
    make install DESTDIR="$PKG_STAGING"

    METADATA_FILE="$PKG_STAGING/car"
    { echo "version $VERSION"; [ -n "$DEPS" ] && for dep in $DEPS; do echo "dep $dep"; done; } > "$METADATA_FILE"
    popd > /dev/null

    tar -I zstd -cf "$OUTPUT_DIR/$NAME.tar.zst" -C "$BASE_STAGING" "$NAME"
    rm -rf "$EXTRACT_FOLDER"
done
