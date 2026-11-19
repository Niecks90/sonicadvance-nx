#!/usr/bin/env bash
# generator.sh — Build gba_recompile (host tool) then generate Sonic Advance
# C++ shards into generated/.
#
# Prerequisites:
#   - A host (non-Switch) build of gbarecomp must have been configured in
#     build_host/ using the native host toolchain.
#   - The Sonic Advance (USA) ROM must be present at the path below.
#   - gba_bios.bin must be present at gbarecomp/bios/gba_bios.bin.
#
# Usage:
#   mkdir -p build_host && cd build_host && cmake ../gbarecomp -DCMAKE_BUILD_TYPE=Release
#   make -j$(nproc) gba_recompile
#   cd .. && ./generator.sh

set -e

ROM_PATH="${1:-roms/sonic_advance_usa.gba}"

if [ ! -f "$ROM_PATH" ]; then
    echo "ERROR: Sonic Advance ROM not found at: $ROM_PATH"
    echo "Usage: $0 [path/to/sonic_advance_usa.gba]"
    exit 1
fi

if [ ! -f "build_host/gba_recompile" ]; then
    echo "ERROR: build_host/gba_recompile not found."
    echo "Build it first:"
    echo "  mkdir -p build_host && cd build_host"
    echo "  cmake ../gbarecomp -DCMAKE_BUILD_TYPE=Release && make -j\$(nproc) gba_recompile"
    exit 1
fi

mkdir -p generated

./build_host/gba_recompile \
    --rom "$ROM_PATH" \
    --config game.toml \
    --config symbols/ASOE_symbols.toml \
    --symbols symbols/imported_symbols.tsv \
    --data-symbols symbols/imported_data_symbols.tsv \
    --out generated \
    --max-functions 65536

echo "Generation complete. Shards written to generated/"
