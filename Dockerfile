# Gunakan image dasar yang sama (misalnya node:18-alpine)
FROM node:18-alpine

# Tambahkan paket yang diperlukan (curl, tar) untuk menginstall Ollama
RUN apk add --no-cache curl tar

WORKDIR /app

# Salin file package.json dan package-lock.json (jika ada) lalu install dependency
COPY package.json package-lock.json* ./
RUN npm install

# Salin seluruh kode Next.js ke dalam container
COPY . .

# Build aplikasi Next.js
RUN npm run build

# Install Ollama menggunakan script resmi
RUN curl -fsSL https://ollama.com/install.sh | sh

# Expose port yang digunakan Next.js
EXPOSE 3000

# Jalankan Ollama di background dan Next.js sebagai proses utama
CMD sh -c "echo 'Starting Ollama...' && ollama serve & echo 'Starting Next.js...' && npm start"