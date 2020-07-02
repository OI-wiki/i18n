You can use the Docker deployment environment.

The following steps must be performed under root user or docker group user

## Pull oi-wiki mirror

```bash
# Run one of the following commands in the host
# Docker Hub image (official image repository)
docker pull 24oi/oi-wiki
# DaoCloud Hub mirror (domestic mirror warehouse, for mainland China user)
docker pull daocloud.io/sirius/oi-wiki
# Tencent Hub mirror (domestic mirror warehouse, for mainland China user)
docker pull ccr.ccs.tencentyun.com/oi-wiki/oi-wiki
```

## Run the container

```bash
# The following command runs in the host
docker run -d -it [image]
```

-   Configure `[image]` (required) to set up the image. For example, if you pull from Docker Hub, it is `24oi/oi-wiki`, and if you pull from DaoCloud Hub, it is `daocloud.io/sirius/oi-wiki`
-   Configure `--name [name]` (default is empty, if you want to view the container id, enter `docker ps`, if you want to change it, please replace `[name]` with a custom name) to set the container name
-   Configure `-p [port]:8000` (required) (If you don’t write this statement, the default is to not expose the port. If you want to set it, please replace `[port]` as the host port) to map the container port to the host port (**OI Wiki** can be accessed on the host using `http://127.0.0.1:[port]`)

## Usage

Based on Ubuntu 16.04 deployment

Enter the container:

```bash
# The following command runs in the host
docker exec -it [name] /bin/bash
```

If you remove `-d` from the above running container, you can directly enter the container bash. After exiting, the container will stop. If you add `-d`, it will run in the background. Please stop it manually. The above entry container operates against the method of adding `-d`.

Special usage:

```bash
# The following command runs in the container
# Update git repository
wiki-upd

# Use our custom theme
wiki-theme

# Build mkdocs and you will get static pages under the site folder
wiki-bld

# Build mkdocs and render MathJax, you will get static pages in the site folder
wiki-bld-math

# Run a server, visit http://127.0.0.1:8000 in the container or visit http://127.0.0.1:[port] in the host to see the effect
wiki-svr

# Correct Markdown
wiki-o
```

Exit the container:

```bash
# The following command runs in the container
# Exit
exit
```

## Stop the container

```bash
# The following command runs in the host
docker stop [name]
```

## Start the container

```bash
# The following command runs in the host
docker start [name]
```

## Restart the container

```bash
# The following command runs in the host
docker restart [name]
```

## Delete container

```bash
# The following command runs in the host
# Please stop the container before deleting
docker rm [name]
```

## Update mirror

Just pull again, usually not updated

## Delete mirror

```bash
# The following command runs in the host
# Please delete the container built with oi-wiki image before deleting
docker rmi [image]
```

## Doubt

If you have any questions, please feel free to open an issue!