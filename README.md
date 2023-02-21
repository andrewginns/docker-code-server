
## Quickstart
First add your ssh key to this project root with the name `id_rsa`.

Then install docker and execute the following to build and start the docker container.

### Build docker container
* `docker build . -t custom_code_server --no-cache`

### Start docker container
* `docker run -d -v ${PWD}:/config/workspace -p 8080:8443 custom_code_server:latest`
  * Exposes port 8080 on the host to access the code-server UI on the docker port 8443
