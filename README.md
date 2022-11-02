# dot

Dotfiles for linux systems

## Setup

Each directory has a `setup` script which can be run independently.

The `setup` script in the root directory runs all the others (except the ones
below) and can be used to completely set up a new system.

`setup` scripts **not** run by root `setup`:
- `git/setup`
- `macos/setup`

See each folder's `README.md` file for more information.

## Contributions

Set up the hooks before contributing:
```bash
.githooks/setup
```

