FROM couchdb:3.4.2

# Copy configuration
COPY local.ini /opt/couchdb/etc/local.d/local.ini

# Check if curl is installed, install if not (CouchDB image usually has it, but good to be safe for the init script)
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copy initialization script
COPY init-couchdb.sh /init-couchdb.sh
RUN chmod +x /init-couchdb.sh

# Set entrypoint
ENTRYPOINT ["/init-couchdb.sh"]
