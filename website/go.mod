module github.com/achourali/cinema-app

go 1.19

require (
	github.com/gorilla/mux v1.8.0
	github.com/achourali/cinema-app/bookings v0.0.0-20221030191256-4469296596ed
	github.com/achourali/cinema-app/movies v0.0.0-20221030191256-4469296596ed
	github.com/achourali/cinema-app/showtimes v0.0.0-20221030191256-4469296596ed
	github.com/achourali/cinema-app/users v0.0.0-20221030191256-4469296596ed
)

require go.mongodb.org/mongo-driver v1.7.1 // indirect
