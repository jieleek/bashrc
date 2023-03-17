import random
import string

def generate_password():
    # Characters that can be easily confused with each other are excluded
    safe_chars = string.ascii_lowercase.replace('l', '').replace('o', '').replace('i', '')
    safe_chars_u = string.ascii_uppercase.replace('I', '').replace('O', '').replace('D', '')
    safe_digits = string.digits.replace('0', '').replace('1', '')

    # At most 1 uppercase, 1 or 2 digits, and remaining lowercase
    char_choices = [
        random.choice(safe_chars_u),
        random.choice(safe_digits),
        random.choice(safe_digits) if random.random() < 0.5 else random.choice(safe_chars),
    ]

    # Fill the rest of the password with lowercase characters
    while len(char_choices) < 18:
        char_choices.append(random.choice(safe_chars))

    # Shuffle the characters to create randomness
    random.shuffle(char_choices)

    # Combine the characters into a single password string
    password = ''.join(char_choices)

    # Split the password into three groups of 6 characters and connect them with hyphens
    password = '-'.join([password[i:i + 6] for i in range(0, 18, 6)])

    return password

generated_password = generate_password()
print(generated_password)
