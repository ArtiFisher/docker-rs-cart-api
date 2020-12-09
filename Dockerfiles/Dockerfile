# Base
FROM node:12.18.3-alpine as build

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build
RUN npm prune --production

# Production
FROM node:12.18.3-alpine as production

COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/dist ./dist

USER node
ENV PORT=8080
EXPOSE 8080

CMD ["node", "dist/main.js"]
