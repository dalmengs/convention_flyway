import requests
import random
import string
import time

API_URL = "http://127.0.0.1:8080/user"
PASSWORD = "12345678"
TOTAL_USERS = 1000
DELAY_SEC = 0.01  # 서버 부하 방지용 (원하면 0으로)

# 간단한 사람 이름 풀
FIRST_NAMES = [
    "Alex", "Chris", "Sam", "Jordan", "Taylor", "Jamie", "Morgan",
    "Ryan", "Daniel", "David", "John", "Michael", "James", "Andrew",
    "Lucas", "Ethan", "Noah", "Leo", "Oscar", "Julian"
]

LAST_NAMES = [
    "Smith", "Johnson", "Brown", "Lee", "Kim", "Park", "Choi",
    "Garcia", "Martinez", "Lopez", "Miller", "Davis", "Wilson",
    "Anderson", "Thomas", "Moore", "Taylor"
]


def random_string(length=6):
    return ''.join(random.choices(string.ascii_lowercase + string.digits, k=length))


def generate_name():
    return f"{random.choice(FIRST_NAMES)} {random.choice(LAST_NAMES)}"


def generate_email(name: str):
    username = name.lower().replace(" ", ".")
    suffix = random_string(4)
    return f"{username}.{suffix}@example.com"


def create_user(i: int):
    name = generate_name()
    email = generate_email(name)

    payload = {
        "email": email,
        "password": PASSWORD,
        "name": name
    }

    response = requests.post(API_URL, json=payload)

    if response.status_code in (200, 201):
        print(f"[{i}] ✅ Created: {email}")
    else:
        print(f"[{i}] ❌ Failed ({response.status_code}): {response.text}")


def main():
    for i in range(1, TOTAL_USERS + 1):
        create_user(i)
        time.sleep(DELAY_SEC)


if __name__ == "__main__":
    main()
