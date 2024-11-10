# Variables

The following is a list of variables you can use to setup your bot.

Those variables are used at the bot's runtime. They will not be stored permanently and will be reused at the container's start.
If you rather wish to *edit* your bot's settings, visit the [editable variables](editable-vars.md) page.

## General

| Variable | Description | Required? | Default |
| -------- | ----------- | --------- | ------- |
| `INSTANCE_NAME` | The name of the instance you wish to use. Technically, this isn't really useful, since you should be hosting one bot per container. | No. | `bot` |
| `TOKEN` | The token of the bot you wish to connect. | Yes, if not set. | N/A |
| `PREFIX` | The prefix you wish to use with you bot. | Yes, if not set. | N/A |
| `STORAGE` | Declares which kind of storage you wish to use. Can either be `json` OR `postgres`. This refers to config backend support used by your bot. There is no default. You should set this and understand the difference. If set to `postgres`, set [PostgreSQL specific variables](#postgresql-specific). | Yes. | N/A |

## Runtime options

| Variable | Description | Required? | Default |
| -------- | ----------- | --------- | ------- |
| `MENTIONABLE` | Makes your bot answer back to ping-like prefix. | No. | Not enabled |
| `ENABLE_DEV` | Enable developers extra functionalities. Not meant for the general user, but can be useful for debugging. | No. | Not enabled |
| `ENABLE_RPC` | Enable the bot's RPC server. See <https://docs.discord.red/en/stable/framework_rpc.html> | No. | Not enabled |
| `RPC_PORT` | Set the RPC's server port. | No. | `6133` (Default from Red-DiscordBot) |
| `VERBOSE_LEVEL` | Increase logs verbosity. This should be a number from 1 to 5, 5 being the highest level of verbosity. | No. | Default (0) |

## Redbot package

| Variable | Description | Required? | Default |
| -------- | ----------- | --------- | ------- |
| `PIP_UGRADE` | pip specific option. Will forcefully upgrade packages if set. Set anything to enable. You can check others options [here](https://pip.pypa.io/en/stable/cli/pip_install/#options), but are less supported. | No. | Will not automatically upgrade |
| `REDBOT_VERSION` | The version of Red-DiscordBot to install. If not specific, this will default to the latest version of Red. If you wish to always obtain the latest version of Red-DiscordBot, set `PIP_UPGRADE` to anything. | No. | Latest version upon first container boot |
| `REDBOT_PACKAGE_URL` | Not intended for the general user. Use this if you wish to install Red-DiscordBot through the use of an URL instead of installing a PyPI package. Useful for installing from a Git repository. | No. | N/A |
| `REDBOT_PACKAGE_EXTRAS` | Not intended for the general user. Declare a list of additional extras to install with Red-DiscordBot when `pip install` will run. (`pip install Red-DiscordBot[Extras are here]`) | No. | None |

## PostgreSQL specific

| Variable | Description | Required? | Default |
| -------- | ----------- | --------- | ------- |
| `PSQL_HOST` | Only use if [`STORAGE`](#general) is set to `postgres`. Set the database's hostname. | Yes, if [`STORAGE`](#general) is set to `postgres` | N/A |
| `PSQL_PORT` | Only use if [`STORAGE`](#general) is set to `postgres`. Set the database's port that will be used to connect. Defaults to `5432`. | No. | `5432` |
| `PSQL_USER` | Only use if [`STORAGE`](#general) is set to `postgres`. Set the database's user that will be used to connect. Defaults to `postgres`. | No. | `postgres` |
| `PSQL_PASSWORD` | Only use if [`STORAGE`](#general) is set to `postgres`. Set the password that will be used to connect to the database. Defaults to the `PSQL_USER` variable. | No. | Value of `PSQL_USER` |
| `PSQL_DATABASE` | Only use if [`STORAGE`](#general) is set to `postgres`. Set the database that will be used by the bot. Default to `postgres`. Defaults to the `PSQL_USER` variable. | No. | Value of `PSQL_USER` |

## The trio of danger

⚠️ These options can be considered dangerous. Understand your action before going all crazy.

| Variable | Description | Required? |
| -------- | ----------- | --------- |
| `OWNER` | ID of the owner who owns the bot. The person you indicate here will have full control both on the bot, and can interact inside the container. You've been warned. | No. |
| `CO_OWNER` | ID of any co owner who may own the bot in addition to the owner. Separated by spaces. The person you indicate here will have full control both on the bot, and can interact inside the container. You've been warned. | No. |
| `TEAM_MEMBERS_ARE_OWNERS` | Indicates that team members can run owner specific commands. They will have full control both on the bot, and can interact inside the container. You've been warned. | No. |
