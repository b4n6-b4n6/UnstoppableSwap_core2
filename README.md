# UnstoppableSwap

This is the monorepo containing the source code for all of our core projects:

- [`swap`](swap/README.md) contains the source code for the main swapping binaries, `asb` and `swap`
  - [`maker`](dev-docs/asb/README.md)
  - [`taker`](dev-docs/cli/README.md)
- [`gui`](src-gui/README.md) contains the new tauri based user interface
- [`tauri`](src-tauri/) contains the tauri bindings between binaries and user interface
- and other crates we use in our binaries

If you're just here for the software, head over to the [releases](https://github.com/UnstoppableSwap/xmr-btc-swap/releases/latest) tab and grab the binary for your operating system! If you're just looking for documentation, check out our [docs page](https://docs.unstoppableswap.net/) or our [github docs](dev-docs/README.md).

Join our [Matrix room](https://matrix.to/#/#unstoppableswap-core:matrix.org) to follow development more closely.

![Screenshot 2024-11-21 at 6 19 03 PM](https://github.com/user-attachments/assets/a9fe110e-90b4-4af8-8980-d4207a5e2a71)

## Contributing

We have a `justfile` containing a lot of useful commands.
Run `just help` to see all the available commands.

## Running tests

This repository uses [cargo-nextest](https://nexte.st/docs/running/) to run the
test suite.

```bash
cargo install cargo-nextest
cargo nextest run
```

## How to build (Docker)
with the new changes building on ubuntu 20.04 is finally possible adding more support to the following distros:
- Ubuntu 20.04
- Ubuntu 22.04
- Ubuntu 24.04
- Debian 11
- Debian 12
- Fedora, arch, and almost any modern distro (since their glibc versions will be newer than 2.31).
- Ubuntu +22.04 and its derivatives (Kubuntu, Xubuntu, etc.)
- Debian +12 (Bookworm) (which uses glibc 2.36) and newer versions
- Fedora +37
- Pop!_OS +22.04 (ubuntu based)
- Arch Linux and its derivatives (Manjaro, EndeavourOS, etc.)
- openSUSE Tumbleweed (not tested)

Note: original project supported only Ubuntu 24.04 !  

To build you simply run the container and copy the outputs ! 
```bash
> docker build -f Linux.Dockerfile -t unstoppable-swap-build .
> docker create -it --name unstoppable-swap-build  unstoppable-swap-build bash
> mkdir output
> docker cp unstoppable-swap-build:/output/. ./output/
```

your build should be in `output` folder 
