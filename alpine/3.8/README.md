# Build Image

`docker build -f Dockerfile -t alpine:3.8.1 -t alpine:latest .`


# Test

`docker run -i -t alpine:3.8 cat /etc/alpine-release`

`docker run -i -t alpine:3.8 /bin/ash`
