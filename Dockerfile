# ========== 1. ベースイメージ ==========
FROM golang:1.23.6-alpine

# 作業ディレクトリを設定
WORKDIR /app

# Air（ホットリロードツール）をインストール
RUN go install github.com/air-verse/air@latest

# ホストのソースコードをコンテナにマウントするため、ここではコピーしない
CMD ["air"]
