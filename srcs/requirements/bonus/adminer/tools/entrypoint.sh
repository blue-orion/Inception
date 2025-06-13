#!/bin/sh

mv adminer-5.3.0.php index.php

exec php-fpm82 -F
