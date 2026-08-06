# CYBERDELIA — Assessment Requirements (READ THIS FIRST)

Fixing the files is **not** enough. Your fixes must **actually take effect on the
running system**, and your submission must prove *you* built and ran it. Marks are
tied to the runtime evidence below, not to config that merely "looks" correct.

---

## 1. Your unique build parameters (derived from your SID)

Your system must be personalised to your Student ID (the `u1234567` you already
replace in the configs). Two values are computed from your SID and **must appear
consistently** across your configuration, your running containers, and your evidence:

- **APP_UID** — the non-root user your application container runs as.
  `APP_UID = 20000 + (last THREE digits of your SID)`
  e.g. SID `u1234567` → `567` → **APP_UID = 20567**

- **APP_PORT** — the internal port your app / reverse proxy listens on and that you publish.
  `APP_PORT = 8000 + (last TWO digits of your SID)`
  e.g. SID `u1234567` → `67` → **APP_PORT = 8067**

> Run `make params` in either the `webserver/` or `dbserver/` folder to print these
> values for your SID (no manual arithmetic needed).
>
> Dropping root means the app can no longer bind port 80 directly. Reconciling that
> with your APP_PORT is part of the task — don't just claim it, show it working.

## 2. Provenance token (integrity)

A **NONCE** codeword will be announced 24–48 hours before the deadline. You must:

1. Run: `echo -n "<your-SID><NONCE>" | sha256sum`
2. Save the full output in **`PROVENANCE.txt`** at the root of your repo.
3. Show that command running, with the NONCE visible on screen, in your screencast.

## 3. Required runtime evidence (report appendix + screencast)

1. **`docker history`** of your hardened image — show the baked secrets and the
   offensive tooling are gone.
2. **Image digest** (`docker images --digests`) and **size**, before vs after hardening.
3. **Vulnerability scan** output (e.g. Trivy or `pip-audit`): the tool + version, the
   total findings by severity, and **at least THREE specific CVE IDs** you remediated,
   naming the package versions involved.
4. **Proof the app runs as your APP_UID**, not root (`docker inspect` / `id` / `ps`).
5. **`PROVENANCE.txt`** and the on-screen NONCE (§2).

### Recommended (not required, but strengthens your submission)
- A **git commit history** (`git log --oneline`) showing incremental work rather than a
  single upload — good evidence of your own process and highly encouraged.
- A **before/after demonstration** of one of the injection flaws (working on the original,
  blocked on your hardened build) is a strong way to prove a fix genuinely took effect.

## 4. What earns marks

- Configuration that looks correct but has **no effect on the running system** earns
  nothing. **Verify every change against the live containers.**
- Your report must reference your own figures ("as shown in Figure N, the container
  runs as UID 205xx"). Prose that can't be tied to your evidence will not be credited.
- Comments in the provided files reflect the *client's* (poor) assumptions. Do not
  trust them — verify each claim before repeating or relying on it.
