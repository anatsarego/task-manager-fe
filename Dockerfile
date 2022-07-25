FROM node:18-alpine as build-step
WORKDIR /build
COPY package.json ./
COPY package-lock.json ./
RUN npm install

COPY . .
RUN npm run build

FROM nginx:1.18-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build-step /build/build /frontend/build 