This folder has information describing the layout and usage of the repository as a whole.
This file (and any sub-readmes) should be documented from the point of view of ease-of-entry,
  leaving the details for later sections only.

- [How do I navigate these notes?](#layout)
- [Where should I put a new note?](#layout)
- [What notes do I want in this repo?](#goals)
- [What notes do I _not_ want in this repo?](#non-goals)
- [How is the structure maintained?](#maintenance)

## Wanted Files

Known locations where I have notes that should end up in this repository.
Eventually, this list should empty out.

- `~/Documents/ideas/NOTES*`
- `~/will`
- `~/Documents/system-notes`
- skel templates

## Layout

Each folder describes a category under which notes can be placed.
Every category folder should have a `README.md` inside to
  - explain its purpose
  - note important sub-folders/files
  - explain how to use it, if it has any additional conventions

When in doubt about where to put a note, follow the readmes.
If a note seems to fit multiple categories, pick one, and optionally use symlinks for the others.

Since we're using the filesystem to categorize, categories are hierarchical.
This has the disadvantage that it is difficult for items to belong under more than one category.
When this happens, I suggest symbolic links.

TODO Hierarchy:
- NOTES
  - Personal
  - Techniques
  - System
    - scripts
    - packages
      - `ripgrep`
        - README.md
        - USAGE.md
        - dotfiles
          - …
        - auto.sh (just anything executable)
          - `version()`
          - `depends()`
          - `install()`
          - `uninstall()`
          - `feature()`
          - `configs()`
        - probe.sh
        - install.sh
      - …

## Goals

- little utility scripts
- skeleton files/directories
- installation directions and scripts
- configuration profiles
- usage notes/cookbooks
- programming techniques
  - proofs of concept
- learning activities
- outstanding usage/configuration questions

### Non-Goals

PDFs likely can't be shared much through github because of their size.
This means research papers can't be saved here.
Their bibTeX _could_ be saved, however.

## Maintenance

The `./scripts/lint.sh` script does some basic checks.
Run it with `--help` to see what it does.

Manual checking of the structure is a recipe for the structure being damaged,
  and eventually the complete rot of the repository.
As such, conventions should be scripted as much as possible.
Let that preference influence the design of the conventions.
