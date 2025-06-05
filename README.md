# TecnoChat - End-to-End Encrypted Chat Application

A secure, real-time chat application with end-to-end encryption built with Next.js, WebSocket, and PostgreSQL.

## Features

- End-to-end encryption for messages
- Real-time chat using WebSocket
- User authentication with JWT
- Mobile-friendly responsive design
- PostgreSQL database for message and user storage
- Apache server configuration for production deployment

## Prerequisites

- Node.js (v16 or higher)
- PostgreSQL database server
- Apache web server
- Domain name (tecnochat.xyz) configured to point to your server

## Local Development Setup

1. Install dependencies:
```bash
npm install
```

2. Create a `.env` file in the root directory:
```env
# Database Configuration
DB_USER=your_db_user
DB_PASSWORD=your_db_password
DB_HOST=localhost
DB_PORT=5432
DB_NAME=tecnochat
DB_SSL=false

# JWT Configuration
JWT_SECRET=your_jwt_secret_key

# Encryption Configuration
NEXT_PUBLIC_ENCRYPTION_KEY=your_encryption_key
```

3. Initialize the database:
```bash
npm run db:init
```

4. Start the development server:
```bash
npm run dev
```

The application will be available at http://localhost:8000

## Production Deployment

1. Build the application:
```bash
npm run build
```

2. Set up Apache Virtual Host:
```apache
<VirtualHost *:80>
    ServerName tecnochat.xyz
    ServerAdmin webmaster@tecnochat.xyz
    DocumentRoot /var/www/tecnochat.xyz/public

    ProxyPreserveHost On
    ProxyPass / http://localhost:8000/
    ProxyPassReverse / http://localhost:8000/

    ErrorLog ${APACHE_LOG_ROOT}/tecnochat.xyz-error.log
    CustomLog ${APACHE_LOG_ROOT}/tecnochat.xyz-access.log combined

    <Directory /var/www/tecnochat.xyz/public>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```

3. Enable required Apache modules:
```bash
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2enmod ssl
```

4. Install SSL certificate using Certbot:
```bash
sudo certbot --apache -d tecnochat.xyz
```

5. Deploy the application:
```bash
# Copy deployment script to server
scp deploy.sh user@your-server:/path/to/deployment/

# Run deployment script
ssh user@your-server "cd /path/to/deployment && ./deploy.sh"
```

## Security Considerations

1. Always use HTTPS in production
2. Keep JWT_SECRET and ENCRYPTION_KEY secure
3. Regularly update dependencies
4. Monitor server logs for suspicious activities
5. Implement rate limiting for API endpoints
6. Regular database backups

## API Endpoints

### Authentication
- POST `/api/auth/register` - Register new user
- POST `/api/auth/login` - Login user

### Messages
- GET `/api/messages` - Fetch chat messages
- POST `/api/messages` - Send new message
- DELETE `/api/messages?id={messageId}` - Delete message

### WebSocket
- WS `/api/ws` - WebSocket endpoint for real-time chat

## Database Schema

### Users Table
```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(50) UNIQUE NOT NULL,
  password TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

### Messages Table
```sql
CREATE TABLE messages (
  id SERIAL PRIMARY KEY,
  sender_id INTEGER REFERENCES users(id),
  content TEXT NOT NULL,
  nonce TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

## Troubleshooting

1. WebSocket Connection Issues:
   - Check if port 8000 is open and available
   - Verify Apache proxy configuration
   - Check SSL certificate validity

2. Database Connection Issues:
   - Verify PostgreSQL is running
   - Check database credentials
   - Ensure database exists and is accessible

3. Apache Configuration:
   - Check Apache error logs: `/var/log/apache2/error.log`
   - Verify virtual host configuration
   - Ensure all required modules are enabled

## License

MIT License

## Support

For support, please open an issue in the repository or contact support@tecnochat.xyz
