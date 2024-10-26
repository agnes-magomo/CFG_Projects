#API-
from flask import Flask, jsonify, request
from db_utils import get_all_movies, delete_movie_by_id, add_movie

app = Flask(__name__)

@app.route("/movies", methods=["GET"])
def get_movies():
    return jsonify( get_all_movies())

@app.route('/movies/remove/<int:id>', methods = ['DELETE'])
def del_movie_using_id(movie_id):
    return jsonify(delete_movie_by_id(movie_id))


@app.route('/movies/add', methods=['POST'])
def add_new_movie():
    movie = request.get_json()
    add_movie(
        title=movie['title'],
        genre=movie['genre'],
        year=movie['year'],
     )


    return jsonify(movie)