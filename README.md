# Minecraft Forge Server – Dockerized Setup

# Project handover
   - PDF-Link - [PDF](<./Minecraft Server Checkliste.pdf>)

## Table of Contents

1. [Project Overview](#project-overview)
2. [Quickstart](#quickstart)
3. [Usage](#usage)
4. [Me](#me)

## 🧱 Project Overview

This project provides a fully containerized Minecraft Forge server setup using Docker and Docker Compose. It is designed for flexibility, mod support, and easy deployment across local or remote environments.

### Key Features

- 🧩 **Forge-based server** with customizable Minecraft and Forge versions via environment variables  
- 📦 **Mod support** through a dedicated volume (`/minecraft/mods`) for easy management  
- ⚙️ **Java memory configuration** using `XMX` and `XMS` environment variables  
- 🔁 **Automatic restart policy** to ensure server uptime  
- 🗂️ **Persistent data storage** for world files, configs, and logs via Docker volumes  
- 🚀 **Simple deployment** with `docker-compose up -d`  

This setup is ideal for developers, modpack creators, or server admins who want a clean, reproducible, and version-controlled Minecraft server infrastructure.

### ⚙️ Prerequisites

Before you can build and run this Minecraft Forge server, make sure you have the following installed and configured:

- 🐳 **Docker**  
  Required to build and run the containerized server environment.  
  [Install Docker](https://docs.docker.com/get-docker)

- 📦 **Docker Compose**  
  Used to manage the container lifecycle and volumes.  
  [Install Docker Compose](https://docs.docker.com/compose/install)

- 🧠 **Basic knowledge of Docker and terminal usage**  
  Familiarity with `docker-compose`, environment variables, and volume mounting is helpful.

- 💾 **Sufficient system resources**  
  At least **2 GB RAM** available for the container, more recommended for modded servers.

- 📁 **Mods directory (optional)**  
  If you plan to use mods, prepare a local folder (e.g. `./mods`) and place your `.jar` files there. These will be mounted into the container automatically.

- 🧬 **Git (optional but recommended)**  
  Useful for cloning this repository, managing version control, and contributing to the project.  
  [Install Git](https://git-scm.com/downloads)

## 🚀 Quick Start

Follow these steps to get your Minecraft Forge server up and running:

1. **Clone the repository**
    ```bash
    git clone https://github.com/Jonathan-Priebe/Minecraft-Server.git
    cd Minecraft-Server
    ```

2. **Build the Docker image**

   ```bash
   docker build -t mc-server:latest .
   ```
   - The default environment variables are defined in the Dockerfile:
   - MC_VERSION – Minecraft version (e.g. 1.21.8)
   - FORGE_VERSION – Forge build version (e.g. 58.1.0)
   - XMX and XMS – Java memory settings (default: 2G and 1G)

3. **Run the container**

    ```bash
    docker run -d -it \
    -p 8888:25565/udp \
    -v mc-data:/minecraft \
    -v mc-mods:/minecraft/mods \
    mc-server:latest
    ```

4. **Alternatively, run it via Docker Compose**

    ```
    docker compose up -d
    ```
    - You can customize environment variables in [Docker-compose file](./docker-compose.yml)
    
    - You can also stop the server with:
    ```
    docker compose down
    ```

## 🛠️ Usage

This section explains how to configure and manage your Minecraft Forge server using the provided Docker setup.

### 🔧 Configuration Overview

All key settings are controlled via environment variables and Docker volumes. You can adjust them in the `docker-compose.yml` file or via CLI when running the container manually.

#### Environment Variables

- `MC_VERSION`: Defines the Minecraft version (e.g. `1.21.8`)
- `FORGE_VERSION`: Specifies the Forge build version (e.g. `58.1.0`)
- `XMX`: Maximum Java heap size (default: `2G`)
- `XMS`: Initial Java heap size (default: `1G`)

Example in [Docker-Compose](./docker-compose.yml):
```yaml
environment:
  MC_VERSION: "1.21.8"
  FORGE_VERSION: "58.1.0"
  XMX: "2G"
  XMS: "1G"
```

### Manage Mods

- Place your `.jar` mod files into the `./mods` directory (if using bind mounts), or into the `mc-mods` volume.
- Mods will be loaded automatically on server startup.

### Server Data

- All world files, configuration, and logs are stored in the `/minecraft` directory inside the container.
- If you're using volumes (`mc-data`), data will persist across container rebuilds and restarts.

### Access Minecraft Shell for Admin Usage:**

```bash
docker attach mc-server
```

- To access the Minecraft terminal, for example to change the gamemode or grant OP status to a user.

> ⚠️ Important: Exit the console properly  
> If you want to leave the container console **without stopping the server**:
> - Do **not** press `Ctrl+C` — this will shut down the server.
> - Instead, press `Ctrl+P` followed by `Ctrl+Q` — this will safely detach your session.

### 🧑‍💻 Access the Container Shell

```bash
docker exec -it mc-server bash
```

This gives you access to the container's internal environment, allowing you to:
- Inspect or edit server files (e.g. server.properties, logs, mod folders)
- Install tools or run scripts inside the container
- Manage configuration without restarting the containe

### Me

- Jonathan Priebe - [LinkedIn](https://www.linkedin.com/in/jonathan-p-34471b1a5/)
