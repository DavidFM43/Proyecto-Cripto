FROM python:3.9-bullseye

ARG userUID=1000

RUN  DEBIAN_FRONTEND=noninteractive apt update && apt install nodejs npm -y

RUN npm install -g n && n stable && n 16.10.0
RUN npm install -g @angular/cli@14.2.10

RUN useradd -m -u $userUID user
USER user

WORKDIR /home/user

RUN mkdir enigma

RUN mkdir -p enigma/frontend/node_modules

COPY /backend/requirements.txt /home/user/enigma/backend/requirements.txt
COPY /frontend/package.json /home/user/enigma/frontend/package.json

RUN pip install -r ~/enigma/backend/requirements.txt && pip install tinyec

RUN export FLASK_APP=colossus
