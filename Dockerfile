# Stage 1: Construir a aplicação
FROM node:18-alpine AS build
WORKDIR /app

# Copiar os arquivos de dependência e instalar
COPY package*.json ./
RUN npm install

# Copiar o restante dos arquivos do projeto
COPY . .

# Construir a aplicação
RUN npm run build

# Stage 2: Criar a imagem final com Nginx
FROM nginx:alpine

# Comando de verificação para garantir que o arquivo nginx.conf existe no contexto de build
RUN ls -la /app

# Copiar a aplicação construída e a configuração do Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Ajuste no caminho para o arquivo nginx.conf (altere o caminho se necessário)
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# Expor a porta 80
EXPOSE 80

# Comando para iniciar o Nginx em modo foreground
CMD ["nginx", "-g", "daemon off;"]
