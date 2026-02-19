#!/bin/bash
set -e

# Start CouchDB in the background
/opt/couchdb/bin/couchdb &
pid=$!

# Wait for CouchDB to be ready
echo "Waiting for CouchDB to start..."
until curl -s http://127.0.0.1:5984/_up > /dev/null; do
    sleep 1
done
echo "CouchDB is up!"

# Configure system databases (idempotent, harmless if they exist)
# Using local admin credentials
creds="${COUCHDB_USER}:${COUCHDB_PASSWORD}"

echo "Initializing databases..."

# _users
curl -s -X PUT "http://127.0.0.1:5984/_users" -u "$creds" || true
# _replicator
curl -s -X PUT "http://127.0.0.1:5984/_replicator" -u "$creds" || true
# _global_changes
curl -s -X PUT "http://127.0.0.1:5984/_global_changes" -u "$creds" || true

echo "Initialization complete."

# Wait for the CouchDB process
wait $pid
