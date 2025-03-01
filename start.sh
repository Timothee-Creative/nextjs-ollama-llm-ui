#!/bin/sh
echo "Starting Ollama..."
# Jalankan Ollama di background
ollama serve &

echo "Starting Next.js..."
# Jalankan Next.js sebagai proses utama
exec npm start