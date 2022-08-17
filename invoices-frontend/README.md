## Description

Front-end repository of invoices (Code Invoice) made with Next.js

**Important**: The Apache Kafka application, Golang (codebank), invoice backend must be running first.

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

Access http://localhost:3002/credit-cards.

### For Windows

Remember to install WSL2 and Docker.