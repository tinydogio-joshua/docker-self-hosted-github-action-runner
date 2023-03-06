# Docker: Self-Hosted GitHub Action Runner

> **Giving Credit Where It's Due:**
> Much of this is based off this article: [https://testdriven.io/blog/github-actions-docker/](https://testdriven.io/blog/github-actions-docker/)

## What is this?

This is a Dockerfile for creating a _self-registering_, _self-hosted_ GitHub Action runner.

## How do I use it?

### Build the Image

> 🚨 The platform flag is needed if you're building on arch64 device like an Apple Silicon based Mac.

```bash
docker build --platform linux/amd64 -t github-action-runner .
```

### Run some Containers Based on the Image

```bash
docker run -d --env ACCESS_TOKEN=${ACCESS_TOKEN} --env ORGANIZATION=${ORGANIZATION} --env REPO=${REPO} --name github-runner-1 github-action-runner

docker run -d --env ACCESS_TOKEN=${ACCESS_TOKEN} --env ORGANIZATION=${ORGANIZATION} --env REPO=${REPO} --name github-runner-2 github-action-runner

docker run -d --env ACCESS_TOKEN=${ACCESS_TOKEN} --env ORGANIZATION=${ORGANIZATION} --env REPO=${REPO} --name github-runner-3 github-action-runner
```

This Image does support also registering at an organization wide level by not including the `REPO` flag in the above example commands:

#### Example

```bash
docker run -d --env ACCESS_TOKEN=${ACCESS_TOKEN} --env ORGANIZATION=${ORGANIZATION} --env REPO=${REPO} --name github-runner github-action-runner
```
