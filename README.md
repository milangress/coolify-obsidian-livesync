# Obsidian Livesync for Coolify

This repository contains the Docker Compose configuration to deploy a self-hosted Obsidian Livesync (CouchDB) server using [Coolify](https://coolify.io).

## Prerequisites

- A Coolify instance.
- A GitHub repository (this one) connected to Coolify.

## Deployment Steps

1.  **Create a New Service in Coolify**:
    - Select **Docker Compose**.
    - Choose **GitHub Repository** as the source.
    - Select this repository and branch.

2.  **Configure Environment Variables**:
    - In the Coolify UI Service Configuration, add the following variables:
        - `COUCHDB_USER`: Your desired username (e.g., `admin`).
        - `COUCHDB_PASSWORD`: Your desired password.

3.  **Configure Domains**:
    - Set the **Domain** for the `couchdb` service to your desired URL, including the port.
    - Example: `https://livesync.yourdomain.com:5984`
    - **Important**: Coolify needs to know the internal port is `5984`. By default, Coolify might try port 80. Explicitly setting the port in the domain configuration (or ensuring the proxy listens to 5984) is crucial. *Actually, correctly in Coolify you usually set the domain to `https://livesync.yourdomain.com` and then inside the service configuration, you set the "Ports Exposes" to `5984`.*

4.  **Deploy**:
    - Click **Deploy**.

## Initialization (First Time Only)

After the service is running, you must initialize the databases (`_users`, `_replicator`, `obsidian`).

1.  **Open Terminal** in Coolify for the `couchdb` container.
2.  Run the following command (replace variables with your values):

```bash
curl -X PUT http://127.0.0.1:5984/_users
curl -X PUT http://127.0.0.1:5984/_replicator
curl -X PUT http://127.0.0.1:5984/_global_changes
```

Or run the official setup script inside the container (if `curl` is installed):

```bash
# You might need to install curl first if the image doesn't have it
apt-get update && apt-get install -y curl

curl -s https://raw.githubusercontent.com/vrtmrz/obsidian-livesync/main/utils/couchdb/couchdb-init.sh | \
hostname=http://127.0.0.1:5984 \
username=$COUCHDB_USER \
password=$COUCHDB_PASSWORD \
bash
```

## Obsidian Client Setup

1.  Install **Self-hosted LiveSync** plugin in Obsidian.
2.  Go to **Settings** -> **Self-hosted LiveSync**.
3.  **Remote Server URL**: `https://livesync.yourdomain.com` (or whatever you configured in Coolify).
4.  **Username**: The `COUCHDB_USER` you set.
5.  **Password**: The `COUCHDB_PASSWORD` you set.
6.  **Database Name**: `obsidian` (or your preferred database name).
7.  Click **Test Connectivity**.
