FROM node:20.11.0-alpine AS base

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"

RUN corepack enable

WORKDIR /app

COPY . .

RUN --mount=type=cache,id=pnpm,target=/pnpm/store \
    pnpm --frozen-lockfile --ignore-scripts install

ENV NODE_ENV=production

EXPOSE 8000

RUN chown -R node /app

USER node

ENV TZ=Europe/London

CMD ["pnpm", "run", "start"]
