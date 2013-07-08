DROP TABLE fav_legislator;

CREATE TABLE fav_legislator;
(
  id SERIAL PRIMARY KEY,
  first VARCHAR(20),
  last VARCHAR(20),
  party VARCHAR(20),
  phone VARCHAR(20),
  state VARCHAR(20),
  twitter_id VARCHAR(20)
  );