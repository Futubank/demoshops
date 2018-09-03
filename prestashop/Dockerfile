# FROM ubuntu:16.04
# 
# EXPOSE 8000
# 
# 
# 
# RUN apt-get update \
#     && DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y software-properties-common \
#     && LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php \
#     && apt-get update \
#     && DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y \
#         wget unzip sudo \
#         php7.0-cli php7.0-gd php7.0-zip  php7.0-xml \
#         php7.0-curl php7.0-mysql php7.0-intl \
#     && mkdir -p /opt/prestashop \
#     && ( cd /opt/prestashop && wget https://download.prestashop.com/download/releases/prestashop_1.7.3.4.zip) \
#     && ( cd /opt/prestashop && unzip prestashop_1.7.3.4.zip ) \
#     && apt-get autoremove -y \
#     && apt-get clean
# 
# # RUN apt-get update \
# #     && DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y \
# #     rsync php-mbstring
# # 
# # ADD docker-entrypoint.sh /
# 
# WORKDIR /opt/prestashop
# 
# #CMD /docker-entrypoint.sh
# CMD sleep 60000

FROM prestashop/prestashop


ENV ADMIN_MAIL=user@example.com \
    ADMIN_PASSWD=123123 \
    PS_DEV_MODE=1 \
    PS_COUNTRY=RU \
    PS_DOMAIN=172.100.0.11 \
    PS_ERASE_DB=0 \
    PS_FOLDER_ADMIN=admin1 \
    PS_FOLDER_INSTALL=install1 \
    PS_INSTALL_AUTO=1 \
    PS_LANGUAGE=ru \
    DB_SERVER=mysql \
    DB_PASSWD=prestashop \
    DB_USER=prestashop \
    DB_NAME=prestashop \
    DB_PORT=3306
#ENV PS_HANDLE_DYNAMIC_DOMAIN 1
