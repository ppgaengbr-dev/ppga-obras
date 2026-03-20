FROM node:20-alpine
WORKDIR /app
COPY . .
RUN corepack enable
RUN corepack prepare pnpm@latest --activate
RUN pnpm install
RUN cd client && pnpm build
RUN pnpm exec esbuild server/_core/index.ts --platform=node --bundle --format=esm --outdir=dist
EXPOSE 3000
CMD ["node", "dist/index.js"]
