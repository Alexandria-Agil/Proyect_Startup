FROM node:16
#Create app directory
WORKDIR /webpage
COPY package*.json ./
RUN ls -al
RUN npm install
COPY ./ ./
ENV NUXT_HOST=0.0.0.0
ENV NUXT_PORT=3002

CMD [ "sh", "-c", "npm run dev -- -p 3002" ]
EXPOSE 3002