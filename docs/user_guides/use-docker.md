# Use Docker

To host an instance using Docker, you use directly the CLI using `#!sh docker run` to start a bot.
This is, however, not the preferred method to keep an instance in check. This is more of a "testing" option.

If you wish to host a bot with a more declarative syntax, use the Docker Compose guide.

In your terminal, run the following command: (This is assuming a Linux system, adapt to your needs)

```sh
RED_TOKEN="Insert your token here"
RED_PREFIX="The prefix to use"
```

```sh
docker run \
  --name redbot \
  -e TOKEN=${RED_TOKEN} \
  -e PREFIX=${RED_PREFIX} \
  -e STORAGE=json \
  -v ./redbot-data:/data
```
