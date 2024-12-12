# Stage 1: Construir a aplicação
FROM node:18-alpine AS build
WORKDIR /app

# Copiar os arquivos de dependência e instalar
COPY package*.json ./
RUN npm install

# Copiar o restante dos arquivos do projeto
COPY . .

# Instalar react-scripts globalmente e construir a aplicação
RUN npm install react-scripts -g
RUN npm run build

# Stage 2: Criar a imagem final com Nginx
FROM nginx:alpine

# Copiar a aplicação construída e a configuração do Nginx
COPY --from=build /app/build /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# Expor a porta 80
EXPOSE 80

# Comando para iniciar o Nginx em modo foreground
CMD ["nginx", "-g", "daemon off;"]
