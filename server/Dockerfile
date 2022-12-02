FROM node:16

# Create app directory
WORKDIR /usr/nickr/documents/fh/semester_7/repo/selfconsumption/server

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

# Bundle app source
COPY . .

EXPOSE 3000

CMD [ "node", "server.js" ]