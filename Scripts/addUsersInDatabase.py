from faker import Faker
import unidecode
import requests

fake = Faker('ro_RO')

# generate a list of 20 random full names
nameList = [fake.name() for _ in range(20)]
nameList = [unidecode.unidecode(name) for name in nameList]

usernameList = []
for i in range(len(nameList)):
    usernameList.append(nameList[i].lower().replace(" ", "."))

url = "http://localhost:8070/api/auth/register"
headers = {'Content-Type': 'application/json'}

for i in range(len(nameList)):
    data = f'{{\n\t"username": "{usernameList[i]}",\n\t"email": "{usernameList[i]}@gmail.com",\n\t"fullName": "{nameList[i]}", ' \
           f'\n\t"password": "1234567"\n}}'

    response = requests.post(url, data=data, headers=headers)
