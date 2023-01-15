module github.com/achourali/cinema-app

go 1.19

require (
	github.com/achourali/cinema-app/bookings v0.0.0-20230115190634-751153adcd4f
	github.com/achourali/cinema-app/movies v0.0.0-20230115190634-751153adcd4f
	github.com/achourali/cinema-app/showtimes v0.0.0-20230115190634-751153adcd4f
	github.com/achourali/cinema-app/users v0.0.0-20230115190634-751153adcd4f
	github.com/gorilla/mux v1.8.0
)

require go.mongodb.org/mongo-driver v1.11.0 // indirect
