FROM --platform=linux/amd64 node:18-alpine

RUN ["npm" ,"install", "-g","pnpm"]

COPY package.json /vite-app/
COPY . /vite-app

WORKDIR /vite-app

RUN ["pnpm", "install"]

CMD ["pnpm", "dev"]

EXPOSE 8000