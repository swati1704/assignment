FROM node:12
Copy . .
RUN npm install
RUN npm build
CMD ["npm","start"]
