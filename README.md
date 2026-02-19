# Obsidian Livesync on Coolify

A zero-config, self-hosting setup for Obsidian Livesync using [Coolify](https://coolify.io).

## Features

- **Automatic Initialization**: No need to manually run curl commands. databases (`_users`, `_replicator`) are created on startup.
- **Coolify Optimized**: Uses "Magic Environment Variables" for secure, automatic credential management.
- **Pre-configured**: `local.ini` is tuned for large requests (4GB limit) and correct CORS settings.

## Deployment Steps

1. **Repo Setup**:
    - Fork or push this repository to your GitHub.

2. **Coolify Setup**:
    - Create a new resource: **Docker Compose** -> **GitHub Repository**.
    - Select this repository.

3. **Environment Variables**:
    - Coolify should automatically generate:
        - `SERVICE_USER_COUCHDB`
        - `SERVICE_PASSWORD_COUCHDB`
        - `SERVICE_FQDN_COUCHDB_5984`
    - **Verify** these exist in the "Environment Variables" tab.

4. **Domains**:
    - In the "General" settings for the service, ensure the **Domain** is set (e.g., `https://livesync.yourdomain.com`).
    - Because we use `SERVICE_FQDN_COUCHDB_5984`, Coolify knows to route this domain to port `5984`.

5. **Deploy**:
    - Click **Deploy**.

## Client Setup (Obsidian)

1. **Install Plugin**: "Self-hosted LiveSync" in Obsidian.
2. **Settings**:
    - **Remote Server URL**: `https://livesync.yourdomain.com` (Your Configured Domain).
    - **Username**: Copy `SERVICE_USER_COUCHDB` from Coolify.
    - **Password**: Copy `SERVICE_PASSWORD_COUCHDB` from Coolify.
    - **Database Name**: `obsidian` (default).
3. **Test**: Click "Test Connectivity".
