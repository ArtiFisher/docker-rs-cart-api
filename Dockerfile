# Base
FROM node:12-alpine AS build
WORKDIR /app

# Dependencies
COPY package*.json ./
RUN npm install

# Build
COPY . .
RUN npm run build



# Release
FROM node:12-alpine
WORKDIR /app
COPY --from=build /app/package.json ./
RUN npm install --only=production && npm cache clean --force

COPY --from=build /app/dist ./dist

# Application
USER node
ENV PORT=8080
EXPOSE 8080

CMD ["node", "dist/main.js"]
