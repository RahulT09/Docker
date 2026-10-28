FROM node:20-alpine AS frontend-builder

WORKDIR /application

COPY ./frontend/package*.json ./
RUN npm install

COPY ./frontend/ ./
RUN npm run build


#Backend build

FROM node:20-alpine as Backend-builder

WORKDIR /application

COPY ./backend/package*.json ./
RUN npm install --omit=dev

COPY ./backend/ ./

COPY --from=frontend-builder /application/dist ./public

EXPOSE 3000

CMD ["node", "server.js"]