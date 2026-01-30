CREATE TABLE "species" (
  "id" integer PRIMARY KEY,
  "name" varchar(255) NOT NULL,
  "pokedex_number" integer NOT NULL,
  "attack" smallint,
  "defense" smallint,
  "special_attack" smallint,
  "special_defense" smallint,
  "speed" smallint,
  "hp" smallint,
  "generation" smallint NOT NULL,
  "classification" varchar(255) NOT NULL,
  "is_legendary" bool DEFAULT false,
  "is_mythical" bool DEFAULT false
);

CREATE TABLE "type" (
  "id" integer PRIMARY KEY,
  "name" varchar(20) NOT NULL
);

CREATE TABLE "species_has_type" (
  "species_id" integer NOT NULL,
  "type_id" integer NOT NULL
);

CREATE TABLE "image" (
  "id" integer PRIMARY KEY,
  "species_id" integer NOT NULL,
  "url" varchar NOT NULL,
  "is_default" bool DEFAULT false
);

CREATE TABLE "sound" (
  "id" integer PRIMARY KEY,
  "species_id" integer NOT NULL,
  "url" varchar NOT NULL,
  "is_default" bool DEFAULT false
);

CREATE TABLE "ability" (
  "id" integer PRIMARY KEY,
  "name" varchar(20) NOT NULL,
  "battle_effect" text NOT NULL
);

CREATE TABLE "species_has_ability" (
  "species_id" integer NOT NULL,
  "ability_id" integer NOT NULL
);

CREATE TABLE "box" (
  "id" integer PRIMARY KEY,
  "name" varchar,
  "description" text
);

CREATE TABLE "caught_pokemon" (
  "id" integer PRIMARY KEY,
  "species_id" integer NOT NULL,
  "nickname" varchar,
  "level" integer NOT NULL,
  "box_id" integer NOT NULL,
  "caught_date" timestamp NOT NULL,
  "updated_at" timestamp,
  "is_shiny" bool DEFAULT false
);

CREATE TABLE "team" (
  "id" integer PRIMARY KEY,
  "name" text NOT NULL,
  "created_at" timestamp NOT NULL,
  "updated_at" timestamp,
  "notes" text
);

CREATE TABLE "team_has_pokemon" (
  "team_id" integer NOT NULL,
  "caught_pokemon_id" integer NOT NULL
);

CREATE UNIQUE INDEX ON "species_has_type" ("species_id", "type_id");

CREATE UNIQUE INDEX ON "species_has_ability" ("species_id", "ability_id");

CREATE UNIQUE INDEX ON "team_has_pokemon" ("team_id", "caught_pokemon_id");

ALTER TABLE "species_has_type" ADD FOREIGN KEY ("species_id") REFERENCES "species" ("id");

ALTER TABLE "species_has_type" ADD FOREIGN KEY ("type_id") REFERENCES "type" ("id");

ALTER TABLE "image" ADD FOREIGN KEY ("species_id") REFERENCES "species" ("id");

ALTER TABLE "sound" ADD FOREIGN KEY ("species_id") REFERENCES "species" ("id");

ALTER TABLE "species_has_ability" ADD FOREIGN KEY ("species_id") REFERENCES "species" ("id");

ALTER TABLE "species_has_ability" ADD FOREIGN KEY ("ability_id") REFERENCES "ability" ("id");

ALTER TABLE "caught_pokemon" ADD FOREIGN KEY ("species_id") REFERENCES "species" ("id");

ALTER TABLE "caught_pokemon" ADD FOREIGN KEY ("box_id") REFERENCES "box" ("id");

ALTER TABLE "team_has_pokemon" ADD FOREIGN KEY ("caught_pokemon_id") REFERENCES "caught_pokemon" ("id");

ALTER TABLE "team_has_pokemon" ADD FOREIGN KEY ("team_id") REFERENCES "team" ("id");
