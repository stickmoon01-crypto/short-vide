FROM node:22-slim

# Install stable pnpm 8
RUN npm install -g pnpm@8.15.9

WORKDIR /app

# Copy package files
COPY package.json pnpm-lock.yaml* ./

# Install production deps (NO --frozen-lockfile)
RUN pnpm install --prod

# Copy the rest of the code
COPY . .

# Build the app
# Build (ensure types are visible)
RUN pnpm build

EXPOSE 3123

CMD ["pnpm", "start"]
