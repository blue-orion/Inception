#!/bin/sh

echo "📁 index.php 파일 존재 여부:"
docker exec nginx ls /var/www/html/index.php

echo "\n🔌 nginx → wordpress 연결 테스트:"
docker exec nginx ping -c 1 wordpress
docker exec nginx nc -zv wordpress 9000 || echo "❌ 포트 연결 실패"

echo "\n📡 php-fpm 포트 열림 여부:"
docker exec wordpress netstat -tulpn | grep php-fpm || echo "❌ php-fpm이 안 돌고 있음"

echo "\n📜 nginx 에러 로그:"
docker logs nginx | tail -n 20

echo "🔍 [1] NGINX 컨테이너에서 index.php로 curl 요청 전송"
docker exec nginx curl -s -o /dev/null -w "%{http_code}\n" http://localhost/index.php

echo "\n📡 [2] tcpdump로 NGINX → php-fpm 네트워크 요청 확인 중 (3초간)"
docker exec nginx sh -c "apk add --no-cache tcpdump > /dev/null 2>&1 && tcpdump -i eth0 port 9000 -c 5 -nn -v"

echo "\n📦 [3] php-fpm 컨테이너에서 로그 확인"
docker logs wordpress 2>&1 | grep 'PHP 요청 수신됨'

echo "\n📂 [4] php-fpm 컨테이너 내 php_access.log 확인"
docker exec wordpress cat /tmp/php_access.log 2>/dev/null || echo "❌ 로그 파일 없음 (PHP에서 수동 생성 필요)"

echo "\n✅ 디버깅 완료: 위 로그에 요청 도달 흔적이 있으면 php-fpm이 정상 작동 중입니다."

