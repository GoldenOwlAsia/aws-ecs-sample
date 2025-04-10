# Stage 1: Build stage
FROM node:20-slim AS builder

WORKDIR /app

COPY package.json package-lock.json ./

# Install required system dependencies
RUN apt-get update && apt-get install -y \
  openssl \
  ca-certificates \
  && rm -rf /var/lib/apt/lists/*

RUN npm install

COPY . .

RUN npx prisma generate

RUN npm run build

FROM node:20-slim

WORKDIR /app

COPY --from=builder /app/.next ./.next
# COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./
COPY --from=builder /app/next.config.js ./

CMD ["npm", "run", "start"]
