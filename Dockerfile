FROM node:22-slim

RUN npm install -g pnpm@8.15.9

WORKDIR /app

COPY package.json pnpm-lock.yaml* ./

# Install ALL deps (including dev) for build
RUN pnpm install --frozen-lockfile

COPY . .

# Build
RUN pnpm build

# Prune to production deps only (smaller runtime image)
RUN pnpm prune --prod

EXPOSE 3123

CMD ["pnpm", "start"]
