# Laravel Dockerized Starter Kit

## Overview
This repository contains a fully Dockerized Laravel application environment.
It supports development and production configurations, automated setup, and seamless deployment using Docker, Docker Compose, and Makefile scripts.

## Features
- Pre-configured Laravel environment for development and production.
- Supports PHP 8.2, Apache, Node.js, and Composer.
- Efficient caching and build optimizations.
- Automated environment-specific configuration syncing.
- Health checks, logs, and container management commands.

## Directory Structure
```
├── src/                 # Laravel application source code
├── docker/              # Environment-specific configurations
│   ├── dev/             # Development environment configs
│   ├── prod/            # Production environment configs
├── Dockerfile           # Dockerfile for building the application image
├── docker-compose.yml   # Docker Compose configuration
├── Makefile             # Makefile for streamlined commands
└── README.md            # Documentation
```

## Getting Started

### Prerequisites
- Docker and Docker Compose installed.
- `.env` file configured with necessary environment variables.

### Setup
1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

2. Build and start the containers:
   ```bash
   make start
   ```

3. Access the application in your browser at `http://localhost` or your configured domain.

### Environment Configuration
The environment is controlled by the `APP_ENV` variable in your `.env` file:
- **`prod`**: For production configuration.
- **`dev`**: For development configuration.

### Available Commands

#### Public Commands
| Command      | Description                                                                 |
|--------------|-----------------------------------------------------------------------------|
| `make start` | Starts the application containers.                                          |
| `make reload`| Reloads the application (useful for `.env` updates).                       |
| `make restart`| Restarts the running container.                                           |
| `make stop`  | Stops the container without removing it.                                   |
| `make shutdown` | Stops and removes all containers and networks.                         |
| `make reset` | Fully resets the application (removes image, rebuilds, and starts again). |
| `make health`| Checks the health status of the running container.                        |
| `make logs`  | Streams container logs.                                                   |
| `make ps`    | Lists active Docker containers.                                           |
| `make system-prune` | Displays Docker system disk usage and allows cleanup.             |


## Contributions
Feel free to fork this repository and submit pull requests. All contributions are welcome!

## License
This project is licensed under the [MIT License](LICENSE).
