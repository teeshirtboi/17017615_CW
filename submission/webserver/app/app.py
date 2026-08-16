# CYBERDELIA :: Ellingson Research Systems "Wall of Fame"
# Handover build from Ac1d_Burn (DevOps). Ships as-is to prod. Works on my machine (tm).

import os
import base64
import zlib
import codecs

import psycopg2
from flask import Flask, request, redirect, render_template_string


app = Flask(__name__)

app.secret_key = "swordfish"


# ============================================================
# Database connection
# ============================================================

DB_HOST = os.environ.get("DB_HOST", "db")
DB_NAME = os.environ.get("DB_NAME", "gibson")


def read_secret_file(variable_name):
    """
    Read a database credential from a Docker Secret file.
    """

    secret_file = os.environ.get(variable_name)

    if not secret_file:
        raise RuntimeError(
            f"Missing required secret variable: {variable_name}"
        )

    try:
        with open(secret_file, "r", encoding="utf-8") as secret:
            return secret.read().strip()

    except OSError as exc:
        raise RuntimeError(
            f"Unable to read Docker secret: {secret_file}"
        ) from exc


DB_USER = read_secret_file("DB_USER_FILE")
DB_PASS = read_secret_file("DB_PASSWORD_FILE")


def db():
    return psycopg2.connect(
        host=DB_HOST,
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASS
    )


# ============================================================
# Wall of Fame page
# ============================================================

WALL = """<!doctype html>
<html>
<head>
    <title>CYBERDELIA :: Wall of Fame</title>
    <link rel="stylesheet" href="/static/style.css">
</head>

<body>

<div class="container">

    <h1>&gt;_ CYBERDELIA</h1>

    <h3>Hack the wall.</h3>

    <form action="/post" method="post">

        <label>Handle:</label>
        <br>

        <input
            type="text"
            name="handle"
            required
        >

        <br>

        <label>Shout-out:</label>
        <br>

        <textarea
            name="message"
            rows="4"
            required
        ></textarea>

        <br>

        <button type="submit">
            TAG THE WALL
        </button>

    </form>

    <br>

    <table>

        <tr>
            <th>Handle</th>
            <th>Shout-out</th>
        </tr>

        %s

    </table>

</div>

</body>
</html>"""


# ============================================================
# Main page
# ============================================================

@app.route("/")
def wall():

    conn = db()
    cur = conn.cursor()

    cur.execute(
        "SELECT handle, message FROM graffiti ORDER BY id DESC"
    )

    rows = ""

    for handle, message in cur.fetchall():

        # Render each row through the existing template.
        rows += render_template_string(
            "<tr><td>{{ h }}</td><td>{{ m }}</td></tr>",
            h=handle,
            m=message
        )

    cur.close()
    conn.close()

    return WALL % rows


# ============================================================
# Post new message
# ============================================================

@app.route("/post", methods=["POST"])
def post():

    handle = request.form["handle"]
    message = request.form["message"]

    conn = db()
    cur = conn.cursor()

    cur.execute(
        "INSERT INTO graffiti (handle, message) VALUES (%s, %s)",
        (handle, message)
    )

    conn.commit()

    cur.close()
    conn.close()

    return redirect("/")


# ============================================================
# Application entry point
# ============================================================

if __name__ == "__main__":

    app.run(
        host="0.0.0.0",
        port=8015,
        debug=False
    )
