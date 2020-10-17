FROM node as builder

RUN mkdir pearProject && \
    git clone https://github.com/a54552239/pearProject.git /pearProject/

COPY .env.production /pearProject/

RUN cd /pearProject && \
    npm install && \
    npm run build

FROM nginx

COPY --from=builder /pearProject/dist/ /usr/share/nginx/html/
