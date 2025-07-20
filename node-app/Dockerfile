# Use Bitnami's stable node image (works even when DockerHub fails)
FROM bitnami/node:18

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

CMD ["node", "index.js"]
