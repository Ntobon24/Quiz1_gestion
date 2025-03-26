# Utilizamos una imagen base de Node.js
FROM node:18 AS builder

# Creamos y definimos el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiamos package.json y package-lock.json para instalar dependencias
COPY package*.json ./

# Instalamos dependencias
RUN npm install

# Copiamos el código de la aplicación
COPY . .

# Construimos la aplicación
RUN npm run build

# Etapa final para servir la aplicación usando una imagen ligera de nginx
FROM nginx:alpine

# Copiamos los archivos generados en la build de Vite al servidor nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# Exponemos el puerto 80 para acceder a la aplicación
EXPOSE 80

# Iniciamos el servidor nginx
CMD ["nginx", "-g", "daemon off;"]
