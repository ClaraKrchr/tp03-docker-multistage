FROM node:18-alpine as build

WORKDIR /app
COPY mon-app/package.json ./
RUN npm install 
COPY mon-app/. ./

RUN npm run build


FROM nginx:alpine

WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=build /app/build .

ENTRYPOINT ["nginx", "-g", "daemon off;"]