module.exports = {
  apps: [{
    name: 'tecnochat',
    script: 'npm',
    args: 'start',
    env: {
      NODE_ENV: 'production',
      PORT: 3000,
      DATABASE_URL: process.env.DATABASE_URL,
      JWT_SECRET: process.env.JWT_SECRET,
      ENCRYPTION_SECRET: process.env.ENCRYPTION_SECRET
    },
    watch: false,
    instances: 1,
    autorestart: true,
    max_memory_restart: '1G',
    error_file: '/var/log/tecnochat/error.log',
    out_file: '/var/log/tecnochat/output.log',
    log_date_format: 'YYYY-MM-DD HH:mm:ss Z'
  }]
};
