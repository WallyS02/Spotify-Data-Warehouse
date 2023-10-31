import album
import artist
import customer
import playback
import playlist
import playlistTrack
import track
import concurrent.futures


def main():
    pool = concurrent.futures.ThreadPoolExecutor(max_workers=50000)
    pool.submit(artist.generate_artists())
    pool.submit(customer.generate_customers())
    pool.submit(album.generate_albums())
    pool.submit(track.generate_tracks())
    pool.submit(playlist.generate_playlists())
    pool.submit(playlistTrack.generate_playlist_tracks())
    pool.submit(playback.generate_playbacks())
    pool.submit(customer.update_customers())
    pool.submit(playlist.update_playlists())


if __name__ == '__main__':
    main()
