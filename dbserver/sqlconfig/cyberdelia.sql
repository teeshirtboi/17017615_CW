-- ============================================================
-- CYBERDELIA hardened database initialisation
-- Database: gibson
-- Application role: cyberdelia
-- ============================================================

\connect gibson

-- Create the Wall of Fame table.
CREATE TABLE IF NOT EXISTS graffiti (
    id SERIAL PRIMARY KEY,
    handle VARCHAR(64) NOT NULL,
    message TEXT
);

-- Application role gets only the permissions required
-- to read and write Wall of Fame entries.

GRANT USAGE ON SCHEMA public TO cyberdelia;

GRANT SELECT, INSERT, UPDATE, DELETE
ON TABLE graffiti
TO cyberdelia;

GRANT USAGE, SELECT
ON SEQUENCE graffiti_id_seq
TO cyberdelia;

-- Seed the Wall of Fame.
INSERT INTO graffiti (handle, message) VALUES
    ('Z3r0C00l', 'Hack the planet!'),
    ('Ac1dBurn', 'Mess with the best, die like the rest.'),
    ('J0shua', 'Shall we play a game?'),
    ('CrashOverride', 'There is no right and wrong. Only fun and boring.'),
    ('Th3Pl4gu3', 'The cake is a lie.');
