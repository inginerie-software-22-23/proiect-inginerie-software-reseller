from faker import Faker
import unidecode
import requests

fake = Faker('ro_RO')

# generate a list of 20 random full names
name_list = [fake.name() for _ in range(20)]
name_list = [unidecode.unidecode(name) for name in name_list]

ls = []
for i in range(len(name_list)):
    ls.append(name_list[i].lower().replace(" ", "."))

url = "http://localhost:8070/api/auth/register"
headers = {'Content-Type': 'application/json'}

for i in range(len(name_list)):
    data = f'{{\n\t"username": "{ls[i]}",\n\t"email": "{ls[i]}@gmail.com",\n\t"fullName": "{name_list[i]}", ' \
           f'\n\t"password": "1234567"\n}}'

    response = requests.post(url, data=data, headers=headers)
