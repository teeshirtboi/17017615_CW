#!/bin/bash

# Start nginx
nginx

# Start the Flask application as the non-root user
su -s /bin/bash appuser -c "python /app/app.py"
