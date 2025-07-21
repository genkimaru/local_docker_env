#!/bin/bash
# Start PostgreSQL as postgres user
su - postgres -c "/usr/pgsql-16/bin/postgres -D /var/lib/pgsql/16/data &"
sleep 5
# Start Hinemos Agent as hinemos user
su - hinemos -c "/opt/hinemos/bin/hinemos_agent start"
# Keep the container running
exec "$@"
