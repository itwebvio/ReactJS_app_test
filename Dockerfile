# Stage 1: Build
FROM node:18-alpine as builder
WORKDIR /app
RUN npm install 
COPY . .
RUN npm start 
# Stage 2: Serve
FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]
