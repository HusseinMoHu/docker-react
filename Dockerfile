# First stage to generate build directory for react
# <npm install> is needed to can use <npm run build>
# from all of this stage take ONLY build directory, and use in the next stage
FROM node:alpine
WORKDIR /app
COPY ./package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Second stage - take ONLY build directory from the previous stage
# then command <start nginx> server which is the default command
# so we don't need to write it
# ngix run your app on port 80 always, for port maping => -p 3000:80
# for AWS use => EXPOSE 80
FROM nginx
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html