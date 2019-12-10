FROM zc2638/php-nginx

# 拷贝nginx配置文件
COPY www.conf /etc/nginx/conf.d/

# 拷贝laravel项目
COPY . /var/www/laravel/

# 设置工作区
WORKDIR /var/www/laravel

# 安装laravel组件
RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ \
 && composer clear-cache \
 && composer install \
 && cp .env.example .env \
 && php artisan key:generate \
 && echo "#!/bin/bash \n nginx \n php-fpm \n tail -f" > init.sh

EXPOSE 80

CMD ["/bin/bash", "init.sh"]

