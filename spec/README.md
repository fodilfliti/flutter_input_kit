# Agent memory map

| File | Read when |
| --- | --- |
| [package.md](package.md) | Starting a task |
| [invariants.md](invariants.md) | Changing fields, validators, exports |
| [decisions.md](decisions.md) | Architecture trade-offs |
| [tasks/](tasks/) | Build order |

## Truth order

1. Code in `lib/`
2. This folder
3. `CHANGELOG.md`
4. `README.md` (humans only)
