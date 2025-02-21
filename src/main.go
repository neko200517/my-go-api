package main

import (
    "github.com/gin-gonic/gin"
		"github.com/gin-contrib/cors"
)

func main() {
    r := gin.Default()

		// Cors
		r.Use(cors.New(cors.Config {
			// アクセスを許可したいアクセス元
			AllowOrigins: []string {
				"http://localhost:5173",
			},
			// アクセスを許可したいHTTPメソッド
			AllowMethods: []string {
				"POST",
				"GET",
				"OPTIONS",
			},
			// 許可したいHTTPリクエストヘッダ
			AllowHeaders: []string {
				"Access-Control-Allow-Credentials",
				"Access-Control-Allow-Headers",
				"Content-Type",
				"Content-Length",
				"Accept-Encoding",
				"Authorization",
			},
		}))

    // GET
    r.GET("/", func(c *gin.Context) {
        c.JSON(200, gin.H{"message": "Hello Go Lang!!"})
    })

    // 8080ポートでサーバー起動
    r.Run(":8080")
}
