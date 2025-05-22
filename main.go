package main

import (
	"os"

	"github.com/gin-gonic/gin"
)

func main() {
	router := gin.Default()

	router.GET("/", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "Hello, World!",
		})
	})

	router.GET("/env", func(c *gin.Context) {
		testValue := os.Getenv("TEST_VALUE")
		if testValue != "" {
			c.JSON(200, gin.H{
				"message": "Valor encontrado",
				"value":   testValue,
			})
		} else {
			c.JSON(404, gin.H{
				"message": "No se encontró la variable de entorno TEST_VALUE",
			})
		}
	})

	// Inicia el servidor en el puerto 8080
	router.Run(":8080")
}
