FROM node:20

WORKDIR /app

COPY package.json ./

RUN npm install

COPY index.html vite.config.js eslint.config.js ./

EXPOSE 5173

CMD ["npm", "run", "dev", "--", "--host"]
