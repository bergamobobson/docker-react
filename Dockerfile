FROM node:16-alpine as builder 

WORKDIR "/app"

COPY package.json .

RUN npm install

#in production environment this is necessary in dev environment we can use volumes
COPY . . 

#the build folder will be create inside /app/build
RUN yarn build 


FROM nginx

#we copy from the previous stage the builder folder to the nginx folder for serving static file
COPY --from=builder /app/build /usr/share/nginx/html
