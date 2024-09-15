import requests
import os
from dotenv import load_dotenv
from pathlib import Path
from pprint import pprint
import spotipy
from spotipy.oauth2 import SpotifyClientCredentials


# Load environment variables from .env file
env_path = Path("/Users/juanitanelson-addy/Documents/Assignment-2/pass_keys.env")
load_dotenv(dotenv_path=env_path)

# Retreiving client_ID & client_secret
client_id = os.getenv("SPOTIPY_CLIENT_ID")
client_secret = os.getenv("SPOTIPY_CLIENT_SECRET")

# Uncomment to check if python can successfully find your credentials
# print("SPOTIPY_CLIENT_ID:", os.getenv('SPOTIPY_CLIENT_ID'))
# print("SPOTIPY_CLIENT_SECRET:", os.getenv('SPOTIPY_CLIENT_SECRET'))

# Initalises Spotify client with credentials
spotify = spotipy.Spotify(auth_manager=SpotifyClientCredentials(client_id=client_id, client_secret=client_secret))

# Introductory message
print("Welcome to the Spotify Information Client!\n"
      "Find out more about your favourite artists,\n"
      "Or even artists you have never heard of!\n"
      "Simply enter in their name and the information will follow.\n")


class UseSpotify:
    def __init__(self, spotify_client):
        self.spotify = spotify_client
    

    def get_artist_info(self, artist_name):
    #This functions purpose is to search for and return artist's information using the API.
        results = spotify.search(q=artist_name, type="artist")
        if results["artists"]["items"]:
            artist = results["artists"]["items"][0]
            artist_name = artist["name"]
            artist_id = artist["id"]
            artist_genres = artist["genres"]
            artist_followers = artist["followers"]["total"]

        capitalised_genres = [genre.title() for genre in artist_genres]

        print(f"Artist: {artist_name}")
        print(f"Genres: {', '.join(capitalised_genres)}")
        print(f"Total Followers: {artist_followers}")
        print("\n")

        # Get albums
        self.artist_albums(artist_id)
        # Get top tracks
        self.artist_top_tracks(artist_id)
        # Get song recommendations
        self.song_recommendations(artist_id)
        return results
    

    def artist_albums(self, artist_id):
        albums = []
        artistalbums = spotify.artist_albums(artist_id=artist_id, include_groups="album,single")
        print("Artist's Discography: ")
        for album in artistalbums["items"]:
            albums.append((album["name"]))
        print("\n".join(albums))
        return albums
        

    def artist_top_tracks(self, artist_id):
        top_tracks = []
        top_10 = spotify.artist_top_tracks(artist_id=artist_id)
        print("\nArtist's Top 10 Tracks Worldwide:")
        for song in top_10["tracks"]:
            top_tracks.append((song["name"]))
        print("\n".join(top_tracks))
        return top_tracks


    def song_recommendations(self, artist_id):
        song_recs = []
        recs = spotify.recommendations(seed_artists=[artist_id], limit=5)
        print("\nRecommended Listens:")
        for track in recs["tracks"]:
            track_name = track["name"]
            track_artist = track["artists"][0]["name"]
            song_recs.append(f"{track_name} by {track_artist}")
        print("\n".join(song_recs))
        return song_recs
    

    def run(self):
        artist_name = input("Please enter the name of an artist: ")
        print("\n")
        results = self.get_artist_info(artist_name)
        save_to_file(results)
    

    def search_again(self):
        while True:
            end_run = input("\nDo you wish to continue searching for artists? (y/n): ")
            if end_run == 'y':
                print("\n")
                spotify_api.run()
            elif end_run == 'n':
                print("\nThank you for using this console app!")
                break
            else:
                print("Invalid response. Please type 'y' or 'n'")

def save_to_file(search_results):
        '''This function allows the user to save the names of the searched artists
        in a .txt file, allowing them to keep track of the artists they have already
        gathered information for.'''
        with open("artist_api_info.txt", "a") as text_file:
            if search_results["artists"]["items"]:
                artist_info = search_results["artists"]["items"][0]
                artist = artist_info["name"]
                artist_genres = artist_info["genres"]
                artist_followers = artist_info["followers"]["total"]

                capitalised_genres = [genre.title() for genre in artist_genres[:3]]

                text_file.write(f"Artist: {artist}\n")
                text_file.write(f"Genres: {', '.join(capitalised_genres[:3])}\n")
                text_file.write(f"Total Followers: {artist_followers}\n")
                text_file.write("\n")
            
            print("\nArtist information successfully saved to artist_api_info.txt.")


# Create an instance of the UseSpotify class
spotify_api = UseSpotify(spotify)

# Call UseSpotify instance with run method
spotify_api.run()

# Call Use Spotify instance with search_again method
spotify_api.search_again()
