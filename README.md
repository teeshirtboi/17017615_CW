# CYBERDELIA - Hardened Container Deployment

## Security Hardening

The CYBERDELIA application was hardened to reduce security risks in the Docker
environment. The web container uses a multi-stage Docker build. Build tools are
kept in the builder stage and unnecessary Python packaging tools are removed
from the runtime image.

The final runtime image uses Alpine Linux and runs the application as a
dedicated non-root user with UID/GID 20615. All Linux capabilities are dropped
and only `CAP_NET_BIND_SERVICE` is added where required. The container also
uses `no-new-privileges:true` to reduce the risk of privilege escalation.

Resource limits are applied to the web container. The final configuration uses
a 256 MB memory limit and a 0.5 CPU limit. A healthcheck is also configured to
verify that the web service is responding correctly.

## Vulnerability Reduction

Trivy was used to scan the container before and after hardening. The final
scan reported zero vulnerabilities for the Alpine operating system and all
detected Python packages. Previously identified vulnerable Python packages
were removed or updated as part of the hardening process.

The final image is approximately 89.8 MB compared with the earlier 1.03 GB
web image, giving a significant reduction in image size and attack surface.

## Verification

The final deployment was tested using Docker Compose. Both the database and
web containers start successfully, with the web container reporting a healthy
status. The application returned HTTP 200 when tested through Nginx.

The running processes were verified to use the non-root `appuser` account.
Provenance was recorded in `PROVENANCE.txt`, and the changes were committed
and pushed to the Git repository.
