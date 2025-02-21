# # ========== 1. ベースイメージ ==========
# FROM golang:1.23.6-alpine

# # 作業ディレクトリを設定
# WORKDIR /app

# # Air（ホットリロードツール）をインストール
# RUN go install github.com/air-verse/air@latest

# # ホストのソースコードをコンテナにマウントするため、ここではコピーしない
# CMD ["air"]

# ========== 1. Build Stage ==========
FROM golang:1.23.6-alpine AS builder

# 作業ディレクトリを設定
WORKDIR /app

# src ディレクトリの go.mod, go.sum をコピーして依存関係を解決
COPY src/go.mod src/go.sum ./
RUN go mod download

# 残りのソースコードをコピー
COPY src/*.go ./

# 実行ファイルをビルド（小さく最適化）
RUN go build -o server main.go

# ========== 2. Run Stage ==========
FROM alpine:latest

# 作業ディレクトリを設定
WORKDIR /app

# builder ステージで作成したバイナリをコピー
COPY --from=builder /app/server /app/

# ポート 8080 を公開
EXPOSE 8080

# 実行ファイルを起動
CMD ["./server"]
