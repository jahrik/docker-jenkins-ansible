# AGENTS.md

This file provides guidance to AI coding agents when working with code in this repository.

## Purpose

Produces `jahrik/docker-jenkins-ansible` — the official `jenkins/jenkins:almalinux` image with Ansible installed (via EPEL), so Jenkins Pipelines can run `ansiblePlaybook(...)` steps directly. A lightweight alternative to Ansible Tower/AWX when paired with the Jenkins [Ansible Plugin](https://plugins.jenkins.io/ansible/).

## Build & Push

```bash
make build   # build locally as jahrik/docker-jenkins-ansible:latest
make push    # push to Docker Hub
make deploy  # docker stack deploy -c docker-compose.yml jenkins (creates /var/jenkins first)
```

## CI

`.github/workflows/build.yml` runs on every push to `main`, every PR, and weekly (Sundays, to pick up new upstream Jenkins releases):
1. Builds the image and verifies both `jenkins.sh --version` and `ansible --version` inside a running container.
2. On `main` only, pushes a multi-arch (amd64 + arm64) image to Docker Hub using the `DOCKERHUB_USERNAME` / `DOCKERHUB_TOKEN` secrets.

## Image internals

- Base: `jenkins/jenkins:almalinux` (tracks upstream Jenkins LTS on AlmaLinux)
- Single `RUN` layer: `yum update`, `epel-release`, `ansible`, then `yum clean all`
- Ansible version floats with EPEL — the weekly rebuild keeps it current
- Drops back to the `jenkins` user after package install; everything else (ports, volumes, entrypoint) is inherited from the upstream image

## Local testing

Build and verify locally:

```bash
docker run --rm jahrik/docker-jenkins-ansible:latest ansible --version
```
