#!/bin/bash

# Start nginx
nginx

# Start the Flask application as the non-root user
su -s /bin/bash appuser -c "cd /app && exec gunicorn --bind 0.0.0.0:5000 --workers 2 app:app"
