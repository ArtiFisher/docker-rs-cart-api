# Base
FROM node:12-alpine AS base

WORKDIR /app

# Dependencies
COPY package*.json ./
RUN npm install

# Build
WORKDIR /app
COPY . .
RUN npm run build


# Production
FROM node:12-alpine

# Dependencies
COPY --from=base /app/package.json ./
RUN npm install --only=production && npm cache clean --force
RUN npm install pm2 -g

COPY --from=base /app/dist ./dist

# Application
USER node
ENV PORT=8080
EXPOSE 8080

CMD ["pm2-runtime", "dist/main.js"]
