# To reproduce

docker build -t repro . && docker run --rm -v$(pwd):/mnt repro
