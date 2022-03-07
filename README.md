# Docker image with Jenkins and Ansible

[![Build](https://github.com/jahrik/docker-jenkins-ansible/actions/workflows/build.yml/badge.svg)](https://github.com/jahrik/docker-jenkins-ansible/actions/workflows/build.yml) [![Docker pulls](https://img.shields.io/docker/pulls/jahrik/docker-jenkins-ansible)](https://hub.docker.com/r/jahrik/docker-jenkins-ansible/)

Based on [jenkins/jenkins:almalinux](https://hub.docker.com/r/jenkins/jenkins/tags)

This makes kicking off Ansible playbooks from Jenkins Pipelines easy

Install the [Ansible Plugin](https://plugins.jenkins.io/ansible/) to Jenkins and you've got yourself an alternative to Ansible Tower or AWX

To get started, put something like this in your Jenkinsfile.

    #!/usr/bin/env groovy

    node('manager') {

      stage('deploy') {
        ansiColor('xterm') {
          ansiblePlaybook(
            playbook: 'playbook.yml',
            inventory: 'inventory.ini',
            colorized: true)
          }
        }

        } catch(error) {
          throw error

        } finally {
          deleteDir()

      }
    }

## Build

The github workflow in this repo will build this image every Sunday, but if you need to build it locally, you can do so.

    make

or

    docker build -t $(USER)/docker-jenkins-ansible .

## Usage

If you clone this repo locally, you can use the Makefile

    make build
    make push
    make pull
    make deploy

Or just use the image uploaded to Dockerhub

    docker run -it jahrik/docker-jenkins-ansible bash
