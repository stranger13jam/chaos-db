# chaos-db

[![ru](https://img.shields.io/badge/lang-ru-green.svg)](https://github.com/stranger13jam/chaos-db/blob/init/README.md)
[![en](https://img.shields.io/badge/lang-en-blue.svg)](https://github.com/stranger13jam/chaos-db/blob/init/README.en.md)

Main repository: https://github.com/stranger13jam/chaos

## Description

**chaos-db** is a database component for the **chaOS** application ecosystem.

The database is one of the core components and is designed to store data for all applications within the **chaOS** application ecosystem.

The data model and all interactions with the database are defined using a Python ORM. A more detailed description of the entities and fields used is provided in the [**chaos-api**](https://github.com/stranger13jam/chaos-api) component description.

## Purpose

This repository contains a `Dockerfile` with the database configuration, which can be used to deploy the database alongside other applications in the **chaOS** ecosystem using Docker Compose. Learn more in the [main repository](https://github.com/stranger13jam/chaos).

> [!NOTE]
> You can also use any other database and any other deployment method you prefer.

## Additional

The repository also contains a `Makefile`, which contains a set of commands for local deployment, testing, and more.