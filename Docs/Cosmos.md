![Cosmos Logo](https://cosmos.network/images/logos/cosmos-logo-white.png)

# Cosmos Quick Documentation

In order for you to run a Validator on Main Net you will need to read the instructions provided by the team.
This document is a quick reference for people who understand how they work and to provide a quick Full Node 
Install and the basic Validator params.

## Full Node Guide
https://github.com/cosmos/gaia/blob/master/docs/join-mainnet.md

## List of Seed Nodes
To edit you config file 
```
nano $HOME/.gaiad/config/config.toml
```
Below are the seeds to use

```
Seed nodes

- `3e16af0cead27979e1fc3dac57d03df3c7a77acc@3.87.179.235:26656` - Bison Trails
- `ba3bacc714817218562f743178228f23678b2873@public-seed-node.cosmoshub.certus.one:26656` - Certus One
- `2626942148fd39830cb7a3acccb235fab0332d86@173.212.199.36:26656` - syncnode
- `3028c6ee9be21f0d34be3e97a59b093e15ec0658@91.205.173.168:26656` - syncnode
- `89e4b72625c0a13d6f62e3cd9d40bfc444cbfa77@34.65.6.52:26656` - Cryptium Labs (@adrianbrink, @awasunyin, @cwgoes)
- `6be0856f6365559fdc2e9e97a07d609f754632b0@cosmos-cosmoshub-2-seed.nodes.polychainlabs.com:26656`
```

For lines ~117–118 persistent_peers = "":
```
persistent_peers = "89e4b72625c0a13d6f62e3cd9d40bfc444cbfa77@34.65.6.52:26656"
```

## Validator Setup Guide
https://github.com/cosmos/gaia/blob/master/docs/validators/validator-setup.md

# Run a Validator on the Cosmos Hub Mainnet

::: tip
Information on how to join the mainnet (`genesis.json` file and seeds) is held [in our `launch` repo](https://github.com/cosmos/launch/tree/master/latest). 
:::

Before setting up your validator node, make sure you've already gone through the [Full Node Setup](https://github.com/cosmos/gaia/blob/master/docs/join-mainnet.md) guide.

If you plan to use a KMS (key management system), you should go through these steps first: [Using a KMS](https://github.com/cosmos/gaia/blob/master/docs/validators/kms/kms.md).

## What is a Validator?

[Validators](https://github.com/cosmos/gaia/blob/master/docs/validators/overview.md) are responsible for committing new blocks to the blockchain through voting. A validator's stake is slashed if they become unavailable or sign blocks at the same height. Please read about [Sentry Node Architecture](./validator-faq.md#how-can-validators-protect-themselves-from-denial-of-service-attacks) to protect your node from DDOS attacks and to ensure high-availability.

::: danger Warning
If you want to become a validator for the Hub's `mainnet`, you should [research security](https://github.com/cosmos/gaia/blob/master/docs/validators/security.md).
:::

You may want to skip the next section if you have already [set up a full-node](https://github.com/cosmos/gaia/blob/master/docs/join-mainnet.md).

## Create Your Validator

Your `cosmosvalconspub` can be used to create a new validator by staking tokens. You can find your validator pubkey by running:

```bash
gaiad tendermint show-validator
```

To create your validator, just use the following command:

::: warning 
Don't use more `uatom` than you have! 
:::

```bash
gaiacli tx staking create-validator \
  --amount=1000000uatom \
  --pubkey=$(gaiad tendermint show-validator) \
  --moniker="choose a moniker" \
  --chain-id=<chain_id> \
  --commission-rate="0.10" \
  --commission-max-rate="0.20" \
  --commission-max-change-rate="0.01" \
  --min-self-delegation="1" \
  --gas="auto" \
  --gas-prices="0.025uatom" \
  --from=<key_name>
```

::: tip
When specifying commission parameters, the `commission-max-change-rate` is used to measure % _point_ change over the `commission-rate`. E.g. 1% to 2% is a 100% rate increase, but only 1 percentage point.
:::

::: tip
`Min-self-delegation` is a stritly positive integer that represents the minimum amount of self-delegated voting power your validator must always have. A `min-self-delegation` of 1 means your validator will never have a self-delegation lower than `1atom`, or `1000000uatom`
:::

You can confirm that you are in the validator set by using a third party explorer.

## Participate in Genesis as a Validator

::: warning
The genesis ceremony for the Cosmos Hub mainnet is closed. Please skip to the next section.
:::

If you want to participate in genesis as a validator, you need to justify that
you have some stake at genesis, create one (or multiple) transactions to bond this stake to your validator address, and include this transaction in the genesis file.

Your `cosmosvalconspub` can be used to create a new validator by staking tokens. You can find your validator pubkey by running:

```bash
gaiad tendermint show-validator
```

Next, craft your `gaiad gentx` command. 

::: tip
A `gentx` is a JSON file carrying a self-delegation. All genesis transactions are collected by a `genesis coordinator` and validated against an initial `genesis.json`.
:::

::: warning Note
Don't use more `uatom` than you have! 
:::

```bash
gaiad gentx \
  --amount <amount_of_delegation_uatom> \
  --commission-rate <commission_rate> \
  --commission-max-rate <commission_max_rate> \
  --commission-max-change-rate <commission_max_change_rate> \
  --pubkey <consensus_pubkey> \
  --name <key_name>
```

::: tip
When specifying commission parameters, the `commission-max-change-rate` is used to measure % _point_ change over the `commission-rate`. E.g. 1% to 2% is a 100% rate increase, but only 1 percentage point.
:::

You can then submit your `gentx` on the [launch repository](https://github.com/cosmos/launch). These `gentx` will be used to form the final genesis file. 

## Edit Validator Description

You can edit your validator's public description. This info is to identify your validator, and will be relied on by delegators to decide which validators to stake to. Make sure to provide input for every flag below. If a flag is not included in the command the field will default to empty (`--moniker` defaults to the machine name) if the field has never been set or remain the same if it has been set in the past.

The <key_name> specifies which validator you are editing. If you choose to not include certain flags, remember that the --from flag must be included to identify the validator to update.

The `--identity` can be used as to verify identity with systems like Keybase or UPort. When using with Keybase `--identity` should be populated with a 16-digit string that is generated with a [keybase.io](https://keybase.io) account. It's a cryptographically secure method of verifying your identity across multiple online networks. The Keybase API allows us to retrieve your Keybase avatar. This is how you can add a logo to your validator profile.

```bash
gaiacli tx staking edit-validator
  --moniker="choose a moniker" \
  --website="https://cosmos.network" \
  --identity=6A0D65E29A4CBC8E \
  --details="To infinity and beyond!" \
  --chain-id=<chain_id> \
  --gas="auto" \
  --gas-prices="0.025uatom" \
  --from=<key_name> \
  --commission-rate="0.10"
```

__Note__: The `commission-rate` value must adhere to the following invariants:

- Must be between 0 and the validator's `commission-max-rate`
- Must not exceed the validator's `commission-max-change-rate` which is maximum
  % point change rate **per day**. In other words, a validator can only change
  its commission once per day and within `commission-max-change-rate` bounds.

## View Validator Description

View the validator's information with this command:

```bash
gaiacli query staking validator <account_cosmos>
```

## Track Validator Signing Information

In order to keep track of a validator's signatures in the past you can do so by using the `signing-info` command:

```bash
gaiacli query slashing signing-info <validator-pubkey>\
  --chain-id=<chain_id>
```

## Unjail Validator

When a validator is "jailed" for downtime, you must submit an `Unjail` transaction from the operator account in order to be able to get block proposer rewards again (depends on the zone fee distribution).

```bash
gaiacli tx slashing unjail \
	--from=<key_name> \
	--chain-id=<chain_id>
```

## Confirm Your Validator is Running

Your validator is active if the following command returns anything:

```bash
gaiacli query tendermint-validator-set | grep "$(gaiad tendermint show-validator)"
```

You should now see your validator in one of the Cosmos Hub explorers. You are looking for the `bech32` encoded `address` in the `~/.gaiad/config/priv_validator.json` file.

::: warning Note
To be in the validator set, you need to have more total voting power than the 100th validator.
:::

## Halting Your Validator

When attempting to perform routine maintenance or planning for an upcoming coordinated
upgrade, it can be useful to have your validator systematically and gracefully halt.
You can achieve this by either setting the `halt-height` to the height at which
you want your node to shutdown or by passing the `--halt-height` flag to `gaiad`.
The node will shutdown with a zero exit code at that given height after committing
the block.

## Common Problems

### Problem #1: My validator has `voting_power: 0`

Your validator has become jailed. Validators get jailed, i.e. get removed from the active validator set, if they do not vote on `500` of the last `10000` blocks, or if they double sign. 

If you got jailed for downtime, you can get your voting power back to your validator. First, if `gaiad` is not running, start it up again:

```bash
gaiad start
```

Wait for your full node to catch up to the latest block. Then, you can [unjail your validator](#unjail-validator)

Lastly, check your validator again to see if your voting power is back.

```bash
gaiacli status
```

You may notice that your voting power is less than it used to be. That's because you got slashed for downtime!

### Problem #2: My `gaiad` crashes because of `too many open files`

The default number of files Linux can open (per-process) is `1024`. `gaiad` is known to open more than `1024` files. This causes the process to crash. A quick fix is to run `ulimit -n 4096` (increase the number of open files allowed) and then restart the process with `gaiad start`. If you are using `systemd` or another process manager to launch `gaiad` this may require some configuration at that level. A sample `systemd` file to fix this issue is below:

```toml
# /etc/systemd/system/gaiad.service
[Unit]
Description=Cosmos Gaia Node
After=network.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/home/ubuntu
ExecStart=/home/ubuntu/go/bin/gaiad start
Restart=on-failure
RestartSec=3
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
```



For a step by step guide for Cosmos vist this link.
https://medium.com/forbole/a-step-by-step-guide-to-join-cosmos-hub-testnet-e591a3d2cb41
https://cosmos.network/docs/cosmos-hub/installation.html#install-gaia
https://medium.com/cryptium-cosmos/how-to-install-cosmos-and-run-your-full-node-public-testnet-df886dc7b226