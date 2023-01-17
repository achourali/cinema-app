package main

import (
	"flag"
	"fmt"
	"log"
	"net/http"
	"os"
	"time"


	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promauto"
	"github.com/prometheus/client_golang/prometheus/promhttp"

	"go.uber.org/zap"
)

type apis struct {
	users string
	movies string
	showtimes string
	bookings string
}

type application struct {
	errorLog *log.Logger
	infoLog  *log.Logger
	apis apis
	Logger *zap.SugaredLogger
}

var requestTotal = promauto.NewCounterVec(prometheus.CounterOpts{
	Name: "http_request_total",
	Help: "Total number of requests",
}, []string{"status"})

func recordMetrics() {
	go func() {
			for {
					opsProcessed.Inc()
					time.Sleep(2 * time.Second)
			}
	}()
}

var (
	opsProcessed = promauto.NewCounter(prometheus.CounterOpts{
			Name: "myapp_processed_ops_total",
			Help: "The total number of processed events",
	})
)

func main() {
	recordMetrics()
	logger := buildLogger()


	http.Handle("/metrics", promhttp.Handler())
	http.ListenAndServe(":2112", nil)
	
	// Define command-line flags
	serverAddr := flag.String("serverAddr", "", "HTTP server network address")
	serverPort := flag.Int("serverPort", 8000, "HTTP server network port")
	usersAPI := flag.String("usersAPI", "http://localhost:4000/api/users/", "Users API")
	moviesAPI := flag.String("moviesAPI", "http://localhost:4000/api/movies/", "Movies API")
	showtimesAPI := flag.String("showtimesAPI", "http://localhost:4000/api/showtimes/", "Showtimes API")
	bookingsAPI := flag.String("bookingsAPI", "http://localhost:4000/api/bookings/", "Bookings API")
	flag.Parse()

	// Create logger for writing information and error messages.
	infoLog := log.New(os.Stdout, "INFO\t", log.Ldate|log.Ltime)
	errLog := log.New(os.Stderr, "ERROR\t", log.Ldate|log.Ltime|log.Lshortfile)

	// Initialize a new instance of application containing the dependencies.
	app := &application{
		infoLog:  infoLog,
		errorLog: errLog,
		apis: apis{
			users: *usersAPI,
			movies: *moviesAPI,
			showtimes: *showtimesAPI,
			bookings: *bookingsAPI,
		},
		Logger: logger,
	}

	// Initialize a new http.Server struct.
	serverURI := fmt.Sprintf("%s:%d", *serverAddr, *serverPort)
	srv := &http.Server{
		Addr:         serverURI,
		ErrorLog:     errLog,
		Handler:      app.routes(),
		IdleTimeout:  time.Minute,
		ReadTimeout:  5 * time.Second,
		WriteTimeout: 10 * time.Second,
	}

	infoLog.Printf("Starting server on %s", serverURI)
	err := srv.ListenAndServe()
	errLog.Fatal(err)
}


func buildLogger() *zap.SugaredLogger {
	config := zap.NewProductionConfig()
	config.Level = zap.NewAtomicLevelAt(zap.InfoLevel)

	l, _ := config.Build()
	return l.Sugar()
}