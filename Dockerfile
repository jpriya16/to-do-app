FROM node:16-alpine3.16 AS build-stage
WORKDIR /app
COPY package.json /app
COPY yarn.lock /app

RUN yarn install --production=true
COPY . /app

RUN yarn build

FROM nginx:alpine
COPY --from=build-stage /app/build/ /usr/share/nginx/html