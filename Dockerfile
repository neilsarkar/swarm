FROM node:4

MAINTAINER neil.r.sarkar@gmail.com

WORKDIR /src

VOLUME /src

RUN npm install -g nodemon

CMD ["nodemon", "app.js"]

EXPOSE 3000
