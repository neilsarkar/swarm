FROM node:4

WORKDIR /src

VOLUME /src

CMD ["node", "app.js"]

EXPOSE 3000
