# Build Phase
FROM node:carbon AS builder

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

COPY . ./

RUN npm run build
#CMD ["npm", "run", "build"]

# Run Phase
FROM nginx
EXPOSE 80
# Copy 'build' from builder to nginx server
COPY --from=builder /usr/src/app/build /usr/share/nginx/html

# No need for CMD as the default command for this image is the one needed
