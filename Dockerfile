# Gunakan image Node.js (alpine)
FROM node:18-alpine

# Buat direktori kerja
WORKDIR /app

# Salin file package.json dan package-lock.json (jika ada), lalu install dependency
COPY package*.json ./
RUN npm install

# Salin seluruh source code ke dalam container
COPY . .

# Build aplikasi Next.js
RUN npm run build

# Install curl (jika belum tersedia) dan Ollama
RUN apk add --no-cache curl bash &&
    curl -fsSL https://ollama.com/install.sh | sh

# Ekspos port Next.js
EXPOSE 3000

# Salin script entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Jalankan script entrypoint
CMD ["/entrypoint.sh"]