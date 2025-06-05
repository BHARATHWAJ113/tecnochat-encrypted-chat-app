#!/bin/bash

# Stop on any error
set -e

# Build the Next.js application
echo "Building Next.js application..."
npm run build

# Create necessary directories
sudo mkdir -p /var/www/tecnochat.xyz
sudo chown -R $USER:$USER /var/www/tecnochat.xyz

# Copy built files to Apache directory
echo "Copying files to Apache directory..."
cp -r .next /var/www/tecnochat.xyz/
cp -r public /var/www/tecnochat.xyz/
cp package.json /var/www/tecnochat.xyz/
cp package-lock.json /var/www/tecnochat.xyz/

# Install production dependencies
cd /var/www/tecnochat.xyz
npm install --production

# Setup PM2 for Node.js process management
echo "Setting up PM2 process..."
pm2 delete tecnochat 2>/dev/null || true
pm2 start npm --name "tecnochat" -- start

# Enable Apache site if not already enabled
sudo a2ensite tecnochat.xyz.conf

# Install SSL certificate using Certbot
echo "Installing SSL certificate..."
sudo certbot --apache -d tecnochat.xyz --non-interactive --agree-tos --email webmaster@tecnochat.xyz

# Restart Apache
sudo systemctl restart apache2

echo "Deployment completed successfully!"
