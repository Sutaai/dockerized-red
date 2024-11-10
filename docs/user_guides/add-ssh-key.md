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
