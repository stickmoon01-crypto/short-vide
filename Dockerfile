FROM node:22-slim

# Install pnpm 8 (Railway reliably supports this version)
RUN npm install -g pnpm@8.15.9

WORKDIR /app

# Copy package files first (better caching)
COPY package.json pnpm-lock.yaml ./

# Install dependencies
RUN pnpm install --frozen-lockfile --prod

# Copy the rest of the code
COPY . .

# Build the app
RUN pnpm build

# Expose the port the repo uses
EXPOSE 3123

# Start command (from the repo)
CMD ["pnpm", "start"]
