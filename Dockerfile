FROM node:18-slim as builder

WORKDIR /src/build-your-own-radar
COPY package.json ./
RUN npm install

COPY . ./

RUN npm run build:prod

FROM nginx:1.23

COPY --from=builder /src/build-your-own-radar/dist /opt/build-your-own-radar
COPY spec/end_to_end_tests/resources/localfiles/* /opt/build-your-own-radar/files/
COPY default.template /etc/nginx/conf.d/default.conf
