import json
from pathlib import Path

DB_PATH = Path("pokemons.json")


def load_db():
    if not DB_PATH.exists():
        return {}
    with open(DB_PATH, "r") as f:
        return json.load(f)


def save_db(db):
    with open(DB_PATH, "w") as f:
        json.dump(db, f, indent=2)


def get_pokemon_from_db(name):
    db = load_db()
    return db.get(name)


def add_pokemon_to_db(pokemon):
    db = load_db()
    db[pokemon["name"]] = pokemon
    save_db(db)
