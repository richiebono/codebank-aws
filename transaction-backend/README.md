## Description

Core bank backend.

## Run the application

### Configure /etc/hosts

The communication between the applications takes place directly through the machine's network.
For this it is necessary to configure an address that all Docker containers can access.

Add to your /etc/hosts (for Windows the path is C:\Windows\system32\drivers\etc\hosts):
```
127.0.0.1 host.docker.internal
```
On all operating systems it is necessary to open the program to edit *hosts* as Administrator of the machine or root.

Run the commands:

```
docker-compose up
```

### For Windows

Remember to install WSL2 and Docker.