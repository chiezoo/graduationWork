#!/bin/bash
set -e

# Rails特有の問題（サーバー起動用ファイルを削除）を解決
rm -f /app/tmp/pids/server.pid

# Dockerfileの「CMD」で指定したコマンドを実行する
exec "$@"
