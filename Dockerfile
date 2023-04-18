FROM node:16-alpine3.16
WORKDIR /app
COPY package.json /app
COPY yarn.lock /app

RUN yarn install --production=true
COPY . /app

RUN yarn build

EXPOSE 3000
CMD ["yarn", "start"]