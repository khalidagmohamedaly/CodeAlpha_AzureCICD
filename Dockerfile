# CodeAlpha DevOps - Tâche 1 : CI/CD Pipeline using Azure
# Image destinée à être poussée vers Azure Container Registry (ACR)
# et déployée sur Azure App Service (Web App for Containers).

FROM node:20-alpine AS builder
WORKDIR /app
COPY app/package*.json ./
RUN npm install --omit=dev --no-fund --no-audit
COPY app/server.js ./

FROM node:20-alpine
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/server.js ./server.js
COPY --from=builder /app/package.json ./package.json

ENV NODE_ENV=production
# Azure App Service for Containers route le trafic vers le port 80 par défaut,
# sauf si WEBSITES_PORT est défini autrement dans les App Settings.
ENV PORT=80
EXPOSE 80

USER appuser

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:80/health || exit 1

CMD ["node", "server.js"]
