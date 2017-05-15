CREATE TABLE songs (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  owner_id INTEGER,

  FOREIGN KEY(album_id) REFERENCES album(id)
);

CREATE TABLE album (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  artist_id INTEGER,

  FOREIGN KEY(artist_id) REFERENCES artist(id)
);

CREATE TABLE artist (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

INSERT INTO
  artist (id, name)
VALUES
  (1, "Strokes"),
  (2, "Vulfpeck");

INSERT INTO
  album (id, title, artist_id)
VALUES
  (1, "Is this it", 1),
  (2, "Mit Peck", 2),
  (3, "My First Car", 2);

INSERT INTO
  songs (id, name, album_id)
VALUES
  (1, "Is This It", 1),
  (2, "The Modern Age", 1),
  (3, "Soma", 1),
  (4, "Barely Legal", 1),
  (5, "Someday", 1),
  (6, "Alone, Together", 1),
  (7, "Last Nite", 1),
  (8, "Hard to Explain", 1),
  (9, "When It Started", 1),
  (10, "Trying Your Luck", 1),
  (11, "Take It Or Leave It", 1),
  (12, "Beastly", 2),
  (13, "It Gets Funkier", 2),
  (14, "Rango", 2),
  (15, "Cars Too", 2),
  (16, "Prom", 2),
  (17, "Tomboy", 2),
  (18, "Wait for the Moment", 3),
  (19, "The Birdwatcher", 3),
  (20, "The Speedwalker", 3),
  (21, "My First Car", 3),
  (22, "Kuhmilch 74 BPM", 3),
  (23, "It Gets Funkier III", 3),
  (24, "Tomboy", 3);
