# Sonic Advance NX (`sonicadvance-nx`)

[![Release](https://img.shields.io/github/v/release/Niecks90/sonicadvance-nx?include_prereleases&color=blue&label=release)](https://github.com/Niecks90/sonicadvance-nx/releases)
[![Platform](https://img.shields.io/badge/platform-Nintendo%20Switch-e60012.svg)](https://www.nintendo.com/switch/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

> **Nintendo Switch Homebrew Port**  
> Ported and optimized for Nintendo Switch by **Niecks90** (v0.1.1).

A native static recompilation port of **Sonic Advance** (Game Boy Advance) for the Nintendo Switch, built on the [`gbarecomp`](https://github.com/mstan/gbarecomp) framework with custom Nintendo Switch Horizon OS / libnx platform integration.

The game ROM and Nintendo GBA BIOS are **not included**. You must provide your own legally obtained copies.

---

## ⚡ Features

- **Native AArch64 Execution:** All 24,000+ GBA routines statically recompiled directly into native 64-bit ARM machine code, running at a locked, buttery-smooth **60 FPS** with zero CPU emulation overhead and minimal battery consumption.
- **Multi-Threaded PPU Worker:** Custom multi-core rendering architecture running the PPU rasterizer on a dedicated thread pinned to **CPU Core 2**, featuring 1:1 sprite fast-path and vertical culling.
- **Audio-Paced Low Latency:** Non-blocking scanout synchronization paced via SDL2 audio buffers on Core 1 to prevent frame starvation.
- **Pixel-Perfect 4:3 Presentation:** Authentic integer presentation preserving the original 240×160 GBA aspect ratio without distortion or uneven pixel scaling.
- **Rear Triggers Support (ZL / ZR):** Ergonomically mapped so ZL acts as L and ZR acts as R.
- **Analog Stick & D-Pad Navigation:** Smooth motion using either the Left Analog Stick (with tuned deadzones) or standard D-Pad directions.
- **Clean Homebrew Exit:** Hold **+ (Start)** and **- (Select)** simultaneously to quit safely back to the Homebrew Menu.
- **Isolated Save Directory:** Automatically creates and organizes saves under `sdmc:/switch/sonicadvance_nx/save/sonic_advance_usa.sav` (Flash 512K / 64 KB).
- **Configurable Settings:** Adjustable parameters through `sdmc:/switch/sonicadvance_nx/config.txt`.

---

## 📦 Installation & SD Card Layout

1. Download `sonic_advance_nx.nro` from the [Latest Release](https://github.com/Niecks90/sonicadvance-nx/releases).
2. Create the directory on your Switch microSD card:
   ```
   sdmc:/switch/sonicadvance_nx/
   ```
3. Place `sonic_advance_nx.nro` inside this folder.
4. Place your legally dumped **Sonic Advance** GBA ROM renamed as `rom.gba`:
   - **Supported Version:** Sonic Advance (USA) (En,Ja) (Game ID: `ASOE`)
   - **Exact Size:** `8,388,608` bytes (8 MB)
   - **SHA-1:** `d842afa7dd1e84de08addb94a51506f1bcafd551`
   - **SHA-256:** `afc29e3325baf68a1822e88b25fcb59c8bdc29b8cdc48fa21c56defbd60ca020`
5. Place your official GBA BIOS dump named `gba_bios.bin`:
   - **Exact Size:** `16,384` bytes
   - **SHA-1:** `300c20df6731a33952ded8c436f7f186d25d3492`
6. Final SD card file structure:

```
/switch/sonicadvance_nx/
 ├── sonic_advance_nx.nro       (The game executable)
 ├── rom.gba                    (Your Sonic Advance USA ROM)
 ├── gba_bios.bin               (Official GBA BIOS image)
 ├── config.txt                 (Auto-generated on first launch)
 └── save/
      └── sonic_advance_usa.sav (Game save file)
```

7. Launch via the **Homebrew Menu** in Title Override mode (hold **R** while opening any installed game from the Switch home screen for full RAM access).

---

## 🎮 Controls

| Switch Controller Input | Game Action |
|:---|:---|
| **D-Pad / Left Analog Stick** | Move / Crouch / Look Up |
| **A / B** | Jump / Spin Dash / Special Actions |
| **L / ZL** | Left Shoulder Action / Trick |
| **R / ZR** | Right Shoulder Action / Trick |
| **+ (Plus / Start)** | Pause / Confirm |
| **- (Minus / Select)** | Select |
| **+ and - held together** | Safe exit back to Homebrew Menu |

---

## ⚙️ Configuration (`config.txt`)

On first launch, `config.txt` is automatically created with default settings:

```ini
vsync = 0
uncapped = 0
cpu_boost = 0
linear_filter = 0
show_fps = 0
audio = 1
```

### Options Breakdown:
- **`audio`** (`1` or `0`): Enables or disables audio processing and output.
- **`vsync`** (`0` or `1`): `0` enables audio-driven pacing (recommended for locked 60 FPS). `1` forces display VSync wait.
- **`linear_filter`** (`0` or `1`): `0` for razor-sharp pixel presentation (recommended), `1` for bilinear smoothing.
- **`show_fps`** (`1` or `0`): Toggles the real-time FPS counter overlay.
- **`cpu_boost`** (`0`, `1`, or `2`): `0` = Normal balanced clock (1020 MHz CPU, full GPU), `1` = FastLoad boost mode, `2` = Type 2 mode.
- **`uncapped`** (`0` or `1`): `0` preserves standard 60 FPS cadence, `1` removes frame pacing cap.

---

## 🛠️ Building from Source

### Prerequisites
- Linux / WSL environment
- [devkitPro](https://devkitpro.org/) with `devkitA64`, `libnx`, and `switch-sdl2` portlibs
- CMake ≥ 3.20 & GCC/Clang

### Build Steps

```bash
# 1. Clone repository
git clone https://github.com/Niecks90/sonicadvance-nx.git
cd sonicadvance-nx

# 2. Place your matching Sonic Advance USA ROM in roms/
mkdir -p roms
cp /path/to/sonic_advance_usa.gba roms/sonic_advance_usa.gba

# 3. Generate static recompilation shards (builds host compiler & translates ROM)
./generator.sh

# 4. Cross-compile for Nintendo Switch
./build_switch.sh
```

The resulting `sonic_advance_nx.nro` will be produced in `build/`.

---

## 🙏 Credits

- **Niecks90**: Nintendo Switch port, AArch64 optimization, multi-core PPU pipeline, and packaging.
- **mstan**: Original [`gbarecomp`](https://github.com/mstan/gbarecomp) framework and static recompilation engine.
- **smiluredev**: [`SonicAdvanceRecomp`](https://github.com/smiluredev/SonicAdvanceRecomp) upstream project.
- **devkitPro**: Nintendo Switch toolchains (`devkitA64`, `libnx`).

---

## ⚖️ Copyright & Legal Disclaimer

- This is an unofficial, non-commercial fan-made port created solely for preservation and educational purposes.
- No copyrighted game code, assets, ROMs, or proprietary BIOS binaries are contained within this repository or distributed in releases.
- *Sonic Advance* and *Sonic the Hedgehog* are registered trademarks of **SEGA Corporation / Sonic Team**.
- *Nintendo Switch* and *Game Boy Advance* are registered trademarks of **Nintendo Co., Ltd.**
