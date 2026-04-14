# Étape 1 : Construire l'application Vue.js
FROM node:20-alpine AS build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
ARG BUILD_ID=local
ENV VITE_BUILD_ID=$BUILD_ID
RUN npm run build
# Étape 2 : Utiliser Nginx pour servir l'application
FROM nginx:alpine AS production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]