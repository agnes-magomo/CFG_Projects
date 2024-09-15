
import requests
import random


def get_harry_characters():
    endpoint= 'https://hp-api.onrender.com/api/characters'
    response = requests.get(endpoint)
    return response.json()

#function to generate trivia question
def display_character_info(name, house, actor,):

    print(f'Character Info:')
    print(f'Name: {name}')
    print(f'House: {house}')
    print(f'Actor: {actor}')

def generate_trivia_question(characters):
    character= random.choice(characters)

    valid_characters = []
    for character in characters:
        name = character.get('name')
        house = character.get('house')
        actor = character.get('actor',[])

#skip characters missing data

        if name and house and actor:
            valid_characters.append(character)

    if not valid_characters:
        return None,None,None,None

#randomly select a character

    character = random.choice(valid_characters)
    name = character.get('name')
    house = character.get('house')
    actor = character.get('actor', [])

#Generate the question based on the selected

    question_type = random.choice(['house', 'name', 'actor'])
    question= 'hello'

    if question_type == 'house':
        question = f'which house does {name} belong to?'
        correct_answer = house
    elif question_type == 'actor':
        question = f'which actor plays {name}?'
        correct_answer = actor

    return question, correct_answer, name, house, actor

#Function to create loop of game
def play_trivia_game():

    characters = get_harry_characters()
    score = 0

    while True:
        question, correct_answer, name, house, actor = generate_trivia_question(characters)
        if not question:
            print('No valid questions could be generated. Exiting game.')
        break

    print(question)
    user_answer = input('Your answer:')

#Comparison of user input and the correct answer
    if user_answer.lower() == correct_answer.strip().lower():
            print('Correct!')
            score += 1
    else: print(f'Incorrect. The correct answer was: {correct_answer}')

    display_character_info(name, house, actor)

    play_again= input('\nDo you want to continue playing? (yes/no)').strip().lower()
    if play_again == 'yes':
        play_trivia_game()

    else: print(f'Game over! Your final score is {score}')

if __name__== '__main__':
    play_trivia_game()
