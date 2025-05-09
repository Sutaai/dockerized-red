# Build arguments

When building the Docker image, you may use a few other special options that you generally can't use with a published image.

To use build arguments in Docker Compose, do the following:

```yaml title="compose.yaml"
services:
  bot:
    build:
      context: https://github.com/Sutaai/dockerized-red
      args:
        ARGUMENTS: here
    ...
```

| Variable         | Description                                                                                                                                                    |
| ---------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `PYTHON_VERSION` | The version of Python you wish to use when running Red-DiscordBot.                                                                                             |
| `APT_INSTALL`    | Additional packages to install during build. This is done during build time and not runtime to avoid downloading packages every time you reboot the container. |
