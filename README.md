# Test to Display Python Graph on Docker on WSL2

Just a project to display Python graphs on Docker using WSL2.

## Prerequisites

Before getting started, make sure you have the following installed:

- WSL2
- Docker
- Docker Compose

## Usage

1. Clone this repository
2. Launch a Docker container

```sh
docker compose up -d
```

3. Run a script file in a container

```sh
docker compose exec app /bin/bash
```

```sh
python src/main.py
```

## Author

- NakuRei

## License

(c) 2024 NakuRei
