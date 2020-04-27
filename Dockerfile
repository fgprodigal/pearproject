FROM node as builder

RUN mkdir pearProject && \
    git clone https://github.com/a54552239/pearProject.git /pearProject/ && \
    cd /pearProject && \
    npm install && \
    sed -i "s/http:\/\/127.0.0.1/http:\/\/192.168.169.188:8888/g" vue.config.js && \
    sed -i "s/https:\/\/beta.vilson.xyz/http:\/\/192.168.169.188:8888\/pearProjectApi/g" src/config/config.js && \
    sed -i "s/crossDomain: false/crossDomain: true/g" src/config/config.js && \
    npm run build

FROM nginx

COPY --from=builder /pearProject/dist/ /usr/share/nginx/html/