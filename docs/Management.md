# Management

This document describes how to manage deployed `Kisser` instances.

## Table of Contents

- [Environment Variables](#environment-variables)
- [Functions](#functions)
  - [`IAuth::rely`](#iauthrely)
  - [`IAuth::deny`](#iauthdeny)

## Environment Variables

The following environment variables must be set for all commands:

- `RPC_URL`: The RPC URL of an EVM node
- `PRIVATE_KEY`: The private key to use
- `KISSER`: The `KISSER` instance to manage

Note that an `.env.example` file is provided in the project root. To set all environment variables at once, create a copy of the file and rename the copy to `.env`, adjust the variable's values', and run `source .env`.

To easily check the environment variables, run:

```bash
$ env | grep -e "RPC_URL" -e "PRIVATE_KEY" -e "KISSER"
```

## Functions

### `IAuth::rely`

Set the following environment variables:

- `WHO`: The address to grant auth to

Run:

```bash
$ forge script \
    --private-key $PRIVATE_KEY \
    --broadcast \
    --rpc-url $RPC_URL \
    --sig $(cast calldata "rely(address,address)" $KISSER WHO) \
    -vvv \
    script/Kisser.s.sol:KisserScript
```

### `IAuth::deny`

Set the following environment variables:

- `WHO`: The address to renounce auth from

Run:

```bash
$ forge script \
    --private-key $PRIVATE_KEY \
    --broadcast \
    --rpc-url $RPC_URL \
    --sig $(cast calldata "deny(address,address)" $KISSER $WHO) \
    -vvv \
    script/Kisser.s.sol:KisserScript
```
