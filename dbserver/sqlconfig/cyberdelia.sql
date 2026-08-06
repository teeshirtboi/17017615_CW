-- CYBERDELIA seed :: run against the 'gibson' database

DROP USER IF EXISTS cyberdelia;
CREATE USER cyberdelia WITH PASSWORD 'w4r3z';

-- give the web user everything, saves us fiddling with grants later
GRANT ALL PRIVILEGES ON DATABASE gibson TO cyberdelia;
ALTER USER cyberdelia WITH SUPERUSER;

DROP TABLE IF EXISTS graffiti;
CREATE TABLE graffiti (
  id      SERIAL PRIMARY KEY,
  handle  VARCHAR(64),
  message TEXT
);
GRANT ALL PRIVILEGES ON TABLE graffiti TO cyberdelia;
GRANT ALL PRIVILEGES ON SEQUENCE graffiti_id_seq TO cyberdelia;

-- seed the wall
INSERT INTO graffiti (handle, message) VALUES
  ('Z3r0C00l',      'Hack the planet!'),
  ('Ac1dBurn',      'Mess with the best, die like the rest.'),
  ('J0shua',        'Shall we play a game?'),
  ('CrashOverride', 'There is no right and wrong. Only fun and boring.'),
  ('Th3Pl4gu3',     'The cake is a lie.');
