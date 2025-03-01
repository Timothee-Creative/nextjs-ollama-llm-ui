#!/bin/sh
# Mulai Ollama di background
ollama serve &

# Mulai aplikasi Next.js
npm run start