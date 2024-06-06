FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin

RUN apt -y update
RUN apt -y install nginx nginx-extras libnginx-mod-http-dav-ext libnginx-mod-http-auth-pam curl dos2unix

RUN mkdir /nvm
ENV NODE_VERSION=18.15.0
ENV NVM_DIR="/nvm"
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV PATH="${NVM_DIR}/versions/node/v${NODE_VERSION}/bin/:${PATH}"

WORKDIR /code
COPY ../BrokenFrontEnd/ ./
RUN chown -R www-data:www-data /code/
RUN npm ci

WORKDIR /script
COPY ./Docker/startscript.sh ./startscript.sh
RUN dos2unix startscript.sh

RUN chown -R www-data:www-data /var/www/html/
COPY ./Docker/nginx.conf /etc/nginx/sites-available/default

RUN apt -y --purge remove dos2unix curl
RUN apt -y autoremove
RUN apt -y autoclean
RUN rm -rf /var/lib/apt/lists/*

EXPOSE 80
EXPOSE 4200

ENTRYPOINT [ "sh" ]
CMD ["./startscript.sh"]