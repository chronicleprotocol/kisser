# Kisser • [![Unit Tests](https://github.com/chronicleprotocol/kisser/actions/workflows/unit-tests.yml/badge.svg)](https://github.com/chronicleprotocol/kisser/actions/workflows/unit-tests.yml) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

`Kisser` is a simple contract allowing auth'ed addresses to kiss customers on `IToll` instances. `Kisser`'s simplicity allows _Chronicle Protocol_ to have it auth'ed on `Scribe(Optimistic)` instances as the contract only allows `kiss()` updates and nothing else.

The contract uses the [`chronicle-std/Auth`](https://github.com/chronicleprotocol/chronicle-std) module for access control.


## Installation

Install module via Foundry:

```bash
$ forge install chronicleprotocol/kisser
```

## Contributing

The project uses the Foundry toolchain. You can find installation instructions [here](https://getfoundry.sh/).

Setup:

```bash
$ git clone https://github.com/chronicleprotocol/kisser
$ cd kisser/
$ forge install
```

Run tests:

```bash
$ forge test
$ forge test -vvvv # Run with full stack traces
$ FOUNDRY_PROFILE=intense forge test # Run in intense mode
```

Lint:

```bash
$ forge fmt [--check]
```

Update gas snapshots:

```bash
$ forge snapshot [--check]
```

## Dependencies

- [chronicleprotocol/chronicle-std@v2](https://github.com/chronicleprotocol/chronicle-std/tree/v2)
