# Stage 1: Construir a aplicação
FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Stage 2: Criar a imagem final com Nginx
FROM nginx:alpine

# Copiar a aplicação construída e a configuração do Nginx

COPY --from=build /app/dist /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]