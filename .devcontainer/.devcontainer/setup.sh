#!/bin/bash
set -e
echo "=== Setup Pterodactyl di Codespace ==="

until docker info > /dev/null 2>&1; do
  echo "Menunggu Docker..."
  sleep 2
done

docker compose up -d

echo "Menunggu Panel siap..."
for i in {1..24}; do
  if docker compose exec -T panel php artisan --version > /dev/null 2>&1; then
    break
  fi
  sleep 5
done

docker compose exec -T panel php artisan p:user:make \
  --email=admin@admin.com \
  --username=admin \
  --name-first=Admin \
  --name-last=Codespace \
  --password=admin123 \
  --admin=1 || echo "Admin sudah ada"

echo "=== BERHASIL ==="
echo "Email: admin@admin.com"
echo "Password: admin123"
