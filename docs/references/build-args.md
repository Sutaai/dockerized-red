# Build arguments

When building the Docker image, you may use a few other special options that you generally can't use with a published image.

| Variable | Description |
| -------- | ----------- |
| `PYTHON_VERSION` | The version of Python you wish to use when running Red-DiscordBot. |
| `APT_INSTALL` | Additional packages to install during build. This is done during build time and not runtime to avoid downloading packages every time you reboot the container. |
