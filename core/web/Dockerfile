# web/Dockerfile
FROM node:20

WORKDIR /app

COPY package*.json ./
#RUN npm install --silent

ENV NODE_ENV=development
ENV NODE_OPTIONS="--max-old-space-size=512"

EXPOSE 3000
CMD ["npm", "run", "start"]