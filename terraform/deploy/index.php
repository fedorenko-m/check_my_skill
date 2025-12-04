<?php
header('Content-Type: text/html; charset=utf-8');
echo "Hello from PHP-FPM!<br>";
echo json_encode([
    'status' => 'ok',
    'service' => 'nginx',
    'env' => 'dev'
]);
