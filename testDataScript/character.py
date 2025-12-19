import json
import requests
import random
import time

API_URL = "http://127.0.0.1:8080/character"
USER_JSON_PATH = "./testDataScript/user.json"
OUTPUT_JSON_PATH = "./testDataScript/user_with_characters.json"

TOTAL_USERS = 10
PUBLIC_COUNT = 50
PRIVATE_COUNT = 50
DELAY = 0.01  # 서버 보호용

CHARACTER_NAMES = [
    "Luna", "Orion", "Nova", "Eris", "Atlas", "Nyx", "Echo",
    "Riven", "Kai", "Mira", "Aiden", "Aria", "Zane", "Iris",
    "Rowan", "Elio", "Seren", "Theo", "Lyra", "Ash"
]


def random_name():
    return f"{random.choice(CHARACTER_NAMES)}-{random.randint(1000, 9999)}"


def create_character(user_id: str, name: str, visibility: str):
    payload = {
        "name": name,
        "tagline": f"{name}'s tagline",
        "description": f"{name} is a generated character.",
        "visibility": visibility
    }

    headers = {
        "X-User-Id": user_id
    }

    response = requests.post(API_URL, json=payload, headers=headers)

    if response.status_code not in (200, 201):
        raise Exception(f"Failed to create character: {response.text}")

    return {
        "name": name,
        "visibility": visibility
    }


def main():
    with open(USER_JSON_PATH, "r", encoding="utf-8") as f:
        users = json.load(f)["data"]

    result = []

    for user in users[:TOTAL_USERS]:
        user_id = user["id"]
        email = user["email"]

        print(f"\n👤 Creating characters for user: {email}")

        characters = []

        # PUBLIC 50
        for _ in range(PUBLIC_COUNT):
            name = random_name()
            characters.append(create_character(user_id, name, "PUBLIC"))
            time.sleep(DELAY)

        # PRIVATE 50
        for _ in range(PRIVATE_COUNT):
            name = random_name()
            characters.append(create_character(user_id, name, "PRIVATE"))
            time.sleep(DELAY)

        result.append({
            "userId": user_id,
            "email": email,
            "characters": characters
        })

    with open(OUTPUT_JSON_PATH, "w", encoding="utf-8") as f:
        json.dump(result, f, indent=2, ensure_ascii=False)

    print(f"\n✅ Done. Output saved to {OUTPUT_JSON_PATH}")


if __name__ == "__main__":
    main()
