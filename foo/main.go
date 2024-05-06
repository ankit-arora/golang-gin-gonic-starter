package main

import (
	"github.com/gin-gonic/gin"
	"log"
)

var version string

func main() {
	log.Println("Starting version", version)
	r := gin.Default()
	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})
	r.Run(":8080")
}
