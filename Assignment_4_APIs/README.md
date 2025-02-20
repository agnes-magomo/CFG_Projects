
### Movie API - Setup and Run Instructions 

This guide explains how to configure settings, and run the API using PyCharm.

for Required package, see requirements file

1. Configure Database Connection
Edit Configuration in db_utils.py:

HOST = "your_database_host"          
USER = "your_database_user"         
PASSWORD = "your_database_password"  
DATABASE = "your_database_name


2. Run the Server:
Test Endpoints:
With the server running, use a web browser or API client (e.g., Postman) to test the following endpoints:
GET all movies: http://127.0.0.1:5000/movies
POST a new movie: http://127.0.0.1:5000/movies/add
DELETE a movie by ID: http://127.0.0.1:5000/movies/remove/<movie_id>
Expected Output

When running the API:

GET should return all movie records.
POST should add a new movie to the database.
DELETE should remove a movie by its movie_id.
The console in PyCharm will show connection status messages and error alerts (if any).

