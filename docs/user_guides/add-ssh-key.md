# Add a SSH key for private repositories

There might be times where you wish to access certain private repositories.
This is something that is easily achieved when hosting Red on your machine, but less easier inside a container.

Dockerized Red do, however, provide a way to register your SSH private key inside the container.
It will automatically add the given SSH key into the SSH agent running in the container, making authentication into private repositories possible.

Due to the security nature of SSH keys, you must use secrets and not environment variables to set your SSH key.

For example, in your compose file:

```yaml
services:
  bot:
    secrets:
      - ssh-key
    ...

secrets:
  ssh-key:
    file: /home/user/.ssh/id_ed25519
```

Once you reboot your container (With updated configuration), the SSH key will be loaded onto the container's SSH agent, and you should be able to access any private repos you have access to.

## Add an host to trust

Before you are able to clone a repository using SSH, you need to trust the host you will connect to. This is a forced requirement by OpenSSH for security reasons.

This image allows you to set which hosts to trust at container's boot using the `TRUST_HOSTS` environment variable. You can add multiple hosts by separating hosts them with `,`.

Example:

```yaml title="compose.yaml"
services:
  bot:
    secrets:
      - ssh-key
    ...
    environment:
      TRUST_HOSTS: github.com, gitlab.com

...
```

This will have the action to scan for the SSH keys of each hosts you have indicated, and add them to the known hosts.

In case you do not do this, Red-DiscordBot will not be able to clone a repository through SSH and will fail.
