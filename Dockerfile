FROM node:22-slim

# Install stable pnpm 8
RUN npm install -g pnpm@8.15.9

WORKDIR /app

# Copy package files first
COPY package.json pnpm-lock.yaml* ./

# Install dependencies
RUN pnpm install --prod

# Copy the rest of the code
COPY . .

# Build the app
RUN pnpm build

# Railway needs this
EXPOSE 3123

# Start command from the repo
CMD ["pnpm", "start"]
