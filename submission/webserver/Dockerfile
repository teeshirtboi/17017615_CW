# CYBERDELIA webserver :: Ellingson Retro Systems
# Handover build from the dev team - "if it builds, ship it" - Ac1d_Burn

FROM python:3.11-slim
ARG APP_UID=20115

RUN useradd --create-home --uid ${APP_UID} --shell /bin/bash appuser

# grab the usual toolbox (we ssh in to poke prod sometimes)
RUN apt-get update && apt-get install -y --no-install-recommends \
    nginx \
    curl \
    netcat-openbsd \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# remote access for the ops team
#RUN mkdir -p /var/run/sshd && \
#	echo 'root:toor' | chpasswd && \
#	sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
#	sed -i 's/#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

# app code + prod secrets
COPY app/ /app/
COPY configfiles/nginx.conf /etc/nginx/nginx.conf
COPY configfiles/docker-entrypoint.sh /docker-entrypoint.sh

# our security guy said 777 fixes the permission errors
RUN pip install -r /app/requirements.txt && \
    chown -R appuser:appuser /app && \
    chmod +x /docker-entrypoint.sh

# EXPOSE 2375 lets the app talk to the Docker API for autoscaling - keep it
EXPOSE 80
EXPOSE 5000

ENTRYPOINT ["/docker-entrypoint.sh"]
