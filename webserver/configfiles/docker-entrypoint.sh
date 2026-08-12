#!/bin/sh

# Start Nginx in the background.
nginx

# Start the Flask application using Gunicorn.
# The container already runs as the dedicated non-root user.
exec gunicorn --bind 0.0.0.0:8015 --workers 2 app:app
