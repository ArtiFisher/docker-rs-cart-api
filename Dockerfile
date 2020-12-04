# Base
FROM node:12-alpine AS build
WORKDIR /app

# Dependencies
COPY package*.json ./
RUN npm install

# Build
COPY . .
RUN npm run build


# Production
FROM node:12-alpine
WORKDIR /app
COPY --from=build /app/dist ./dist

# Dependencies
COPY --from=build /app/package.json ./
RUN npm install --only=production && npm cache clean --force

# Application
USER node
ENV PORT=8080
EXPOSE 8080

CMD ["node", "dist/main.js"]
