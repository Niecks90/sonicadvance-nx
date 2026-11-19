# symbols/

Symbol and boundary metadata for the Sonic Advance recompilation.
It is a discovery and readability aid, not execution truth; runtime/oracle
evidence remains authoritative.

## Status

Stubs only. Populate by running the gbarecomp symbol importer against a
Sonic Advance decomp ELF:

```sh
python gbarecomp/tools/symbol_import/import_decomp_symbols.py \
    --id AXPE --name "Sonic Advance (USA)" \
    --syms  symbols/sa_readelf_syms.txt \
    --sections symbols/sa_readelf_sections.txt \
    --map   symbols/sa.map \
    --rom   roms/sonic_advance_usa.gba \
    --out   symbols
```

Then `./generator.sh` and rebuild.

## Tracked files

| File | Consumed by | Notes |
|---|---|---|
| `imported_symbols.tsv` | `gba_recompile --symbols` | Function seeds |
| `imported_data_symbols.tsv` | `gba_recompile --data-symbols` | Named memory regions |
| `AXPE_symbols.toml` | `gba_recompile --config` (second) | `[identity]` gate + data ranges |
| `function_boundaries.tsv` | future tooling | Exact extents from `st_size` |

## MKSC backup files

The original Mario Kart: Super Circuit symbol files are preserved as
`*.mksc_bak` in this directory and can be safely removed once the SA
symbol set is confirmed working.
