# START HERE — CYBERDELIA (7009SCN Coursework)

You've been handed a small, **deliberately insecure** two-container web app
("CYBERDELIA", a Wall of Fame). Your job is to evaluate it, harden it, and write it up.
Work through the steps below in order.

## Read these first (they define your task and your grade)
1. **The assignment brief** (on Aula) — the authoritative task list and marking scheme:
   Part A (analysis, ~2500 words), Part B (implementation + a 5-minute screencast),
   Part C (production cloud strategy, ~1500 words).
2. **`ASSESSMENT_REQUIREMENTS.md`** (this folder) — the specific rules for *this* build:
   your personal `APP_UID` / `APP_PORT`, the provenance token, and the runtime evidence
   you must capture.

## What you need installed
- Docker (Desktop or Engine) and `make`
- A code editor and, recommended, `git` — keeping a commit history as you work makes
  for a much stronger submission (not required)

## Step 1 — Make it yours
In `webserver/Makefile` and `dbserver/Makefile`, replace `u1234567` with your Student ID.
Then, from either folder, print your two personal numbers and note them down:
```
make params
```

## Step 2 — Get the baseline running (as-is, insecure)
Start the database first, then the web server:
```
cd dbserver    && make && make run
cd ../webserver && make && make run
```
Open <http://localhost/> — you should see the Wall of Fame with some seed messages.
**This is the starting point you have to secure.** Poke at it and read every file.
Clean up any time with `make clean` in each folder.

## Step 3 — Do the assessment
- **Part A** — evaluate the prototype's image/build security, host/engine security, and
  operations, and recommend improvements (see the brief).
- **Part B** — implement your core fixes on this system and demonstrate it working.
  **Golden rule: a fix only counts if it changes the *running* system.** Test every
  change against live containers — don't just edit files and assume.
- **Part C** — design the production cloud deployment (see the brief).

A sensible order: run it → understand each file → fix the highest-risk issues first →
re-run and confirm → capture evidence → write up.

## Step 4 — Capture evidence as you go
`ASSESSMENT_REQUIREMENTS.md` lists exactly what to record (image digest & size, a
vulnerability scan, proof it runs as your `APP_UID`, a before/after exploit, the
provenance token, etc.). Grab these *while you work* — don't leave them to the end.

## Step 5 — Package & submit
- **Report** `7009SCN_SID.pdf` → Aula (Part A + Part C + references + your OneDrive link).
- **Files** `7009SCN_SID.zip` → OneDrive, **shared** with both staff named in the brief,
  with the link pasted into your report.
- Keep this folder's structure — the Makefiles expect `params.mk` to sit next to the
  `webserver/` and `dbserver/` folders. Include your README, all (commented) config
  files, and the screencast.

## Stuck?
If something won't work, document what you tried, the errors you saw, and your reasoning
— per the brief, that still earns credit. Ask for help early.
