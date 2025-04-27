# About this image

## Difference between PhasecoreX's image

PhasecoreX's image and mine are very different.

First of all, I don't have much knowledge about Red-DiscordBot itself. It's also the first Docker image I am publishing and I am not that knowledgeable about it.

Second is, I am not a developer. I am a simple sys admin, I want to do things fast, quick, and the lazy way. I want to do things that work. While I'm at it, also build some docs, let others see my work, maybe use it, and all. It's experience I gain after all.

For technical differences:

- PhasecoreX's image does not much usage of environment variables to setup your bot, making usage with tools like [Portainer](https://www.portainer.io/) difficult.
- PhasecoreX's image has specific tags for specific purposes (Such as "noaudio", "extra", etc.), whereas this image allows you only to specifies dependencies to download.
- PhasecoreX's image will always fetch a latest version of Red upon restart. Will I do believe this isn't so bad, I am unsure if this is the way to go. I allow you to do so, but you have to implicitly declare to auto update.
- PhasecoreX's image has no support of SSH keys, making cloning of private repositories impossible.
- PhasecoreX's image is very opinionated towards the JSON config driver.
- PhasecoreX's has no docs. A README doesn't count. Sorry. :(
- PhasecoreX's can run rootless. I only do rootful. This may have security implication.
- PhasecoreX's has a [cog that integrates with their Docker images for updates](<https://github.com/PhasecoreX/PCXCogs>).

## Image's actions

Inside the container, the following paths are used:

| Path                      | Description                                                                                                                                               |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `/data`                   | Used for storing all data of the bot. Contains its virtual environment (venv), bot's settings, downloaded cogs and logs. This MUST be saved by the user.  |
| `/usr/src/dockerized-red` | Contains the scripts used for launching the Red instance. Available at `src` on the code's repository.                                                    |
| `/run/secrets/ssh-key`    | In case the user wish to add its SSH key (For reading private repositories for example), this file will be read and added onto the container's SSH agent. |
