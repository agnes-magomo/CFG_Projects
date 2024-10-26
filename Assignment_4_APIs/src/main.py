#client front end
import requests
import json

def get_all_movies_front_end():
    endpoint = 'http://127.0.0.1:5000/movies'
    result = requests.get(endpoint).json()
    return result


def delete_movie_by_movie_id(id):
    endpoint = f'http://127.0.0.1:5000/movies/remove/ {id}'
    result = requests.delete(endpoint).json()
    return result.json


def add_new_movie_front_end(title, genre,year):
    new_movie = {
        'title': title,
        'genre': genre,
        'year': year
    }
    endpoint = 'http://127.0.0.1:5000/movies/add'
    result = requests.post (
        endpoint,
        headers= {'content- type': 'application/jason'},
        data= json.dumps(new_movie)
    )

    return result.json()


def display_movies(records):

        print("{:<30} {:<20} {:<10}".format('TITLE', 'GENRE', 'YEAR'))
        print('-' * 65)

        for item in records:
            print("{:<30} {:<20} {:<10}".format(
                item['title'], item['genre'], item['year']
            ))

def run():
    print("\nWelcome to the Movie Admin Registry!")
    print("---------------------------------")
    print("Choose an option:")
    print("A: View all movie records")
    print("B: Remove a movie by ID")
    print("C: Add a NEW movie ")
    print("---------------------------------")

    answer = input("What would you like to do? (A, B or C): ").strip().upper()

    if answer == "A":
        movies = get_all_movies_front_end()
        if movies is None:
            print("Failed to retrieve records.")
        else:
            display_movies(movies)

    elif answer == "B":
        movies = get_all_movies_front_end()
        if movies is not None:
            print("Here is the movie registry: \n")
            display_movies(movies)

            id_to_remove = input("\nEnter the ID of the movie you would like to remove: ").strip()
            updated_records = delete_movie_by_movie_id(id_to_remove)
            if updated_records:
                print("Movie removed from registry. Updated list:\n")
                print(display_movies(updated_records))
        else:
            print("Could not load movies for deletion.")

    elif answer == "C":

        title = input("Enter movie title: ").strip()
        genre = input("Enter movie genre: ").strip()
        year = input("Enter movie year: ").strip()

        new_movie = add_new_movie_front_end(title, genre, year)
        if new_movie:
            print("Movie added successfully. Updated list:\n")
            updated_movies = get_all_movies_front_end()
            print(display_movies(updated_movies))

    else:
        print("Invalid option. Please select either A, B, or C.")


if __name__ == "__main__":
    run()