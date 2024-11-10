# Docker Compose

## Using the published image

Below is a quick-start compose file you can use. Place its content into a file called `compose.yaml` ([Or any other valid name for Compose](https://docs.docker.com/compose/intro/compose-application-model/#the-compose-file)).

```yaml title="compose.yaml"
services:
  bot:
    image: sutaai/dockerized-red
    restart: unless-stopped
    volumes:
      - bot-data:/app
    environment:
      INSTANCE_NAME: bot
      STORAGE: json

volumes:
  bot-data:
```

You can customize further your instance by looking at the [reference variables](../references/variables.md).

Once saved, you can launch your bot using `#!sh docker compose up`. This will launch your bot. Your terminal will be attached to the container's output.

The advantage of the published image is to provide an acceptable starting point for most users.

## Bring your own image

There might be a point where the published Docker image is not enough for you. This could be because a specific cogs has specific requirements, or require other dependencies not included by default.

Whenever that happens, you can build your own image with your own arguments that will be passed during the image's build.

You can build your own image with Docker Compose, using the `#!yaml build:` key instead of `#!yaml image:`, and replace the value with the URL of the repository.

The changes look like this:

```yaml title="compose.yaml"
services:
  bot:
    {--image: ReplaceMe--}
    {++build: https://github.com/Sutaai/dockerized-red++}
    ...
```

To know which variables you can use, see the [references of build arguments](../references/build-args.md).

## Find more examples

You can find more example on the [repository](https://github.com/Sutaai/dockerized-red), in the `examples/` folder.
