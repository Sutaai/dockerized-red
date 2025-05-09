# Editable Variables

By design, Red-DiscordBot will store certain informations of your bot into its set storage (JSON or Postgres).

The pros it provide is to allow you to remove certain information stored in your environment variable that you might consider sensible, such as your bot's token, from your environment variables/compose file, if you so care.
The cons is that it come down to the cost of losing information in case of migration, and loss of context. It will also slightly reduce boot time of the bot's process.

Those variables replace a few others variables you can find in [the variable page](variables.md).

| Variable      | Description                                                                   | Replace... |
| ------------- | ----------------------------------------------------------------------------- | ---------- |
| `EDIT_TOKEN`  | Will edit the token of the bot used at bot's startup.                         | `TOKEN`    |
| `EDIT_PREFIX` | Will edit the default prefixes by the bot.                                    | `PREFIX`   |
| `EDIT_OWNER`  | Will edit the owner of the bot. Be careful who you give owner permissions to. | `OWNER`    |
