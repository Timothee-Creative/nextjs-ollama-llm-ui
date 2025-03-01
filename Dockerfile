# Gunakan image dasar Node.js, misalnya versi Alpine
FROM node:20-alpine

# Setel direktori kerja di dalam container
WORKDIR /app

# Pastikan kita memiliki tool yang dibutuhkan untuk instalasi Ollama
RUN apk add --no-cache curl tar

# -----------------------
# 1) Instalasi Ollama
# -----------------------
# Download file tar Ollama versi Linux AMD64
RUN curl -L https://ollama.com/download/ollama-linux-amd64.tgz -o /tmp/ollama-linux-amd64.tgz \
    && tar -C /usr -xzf /tmp/ollama-linux-amd64.tgz \
    && rm /tmp/ollama-linux-amd64.tgz

# Notes:
# - Jika perlu versi ARM64 (misal di Mac M1/M2), ganti tautan 
#   ke ollama-linux-arm64.tgz.
# - Jika Anda menggunakan GPU AMD, bisa menambahkan paket rocm 
#   (ollama-linux-amd64-rocm.tgz) dengan perintah serupa.
# - Tidak menambahkan systemd atau service agar Ollama TIDAK dijalankan otomatis.

# -----------------------
# 2) Instalasi Aplikasi
# -----------------------
# Salin file package.json dan package-lock.json (jika ada)
COPY package*.json ./

# Instal dependensi
RUN npm install

# Salin seluruh kode sumber ke dalam container
COPY . .

# Buka port aplikasi Next.js (misal di port 3000)
EXPOSE 3000

# Jalankan perintah default untuk Next.js
CMD ["npm", "run", "dev"]