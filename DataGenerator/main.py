import album
import artist
import customer
import playback
import playlist
import playlistTrack
import track
import concurrent.futures


def main():
    first_snapshot()
    second_snapshot()


def first_snapshot():
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


def second_snapshot():
    pool = concurrent.futures.ThreadPoolExecutor(max_workers=50000)
    pool.submit(artist.expand_artists())
    pool.submit(customer.expand_customers())
    pool.submit(album.expand_albums())
    pool.submit(track.expand_tracks())
    pool.submit(playlist.expand_playlists())
    pool.submit(playlistTrack.expand_playlist_tracks())
    pool.submit(playback.expand_playbacks())


if __name__ == '__main__':
    main()
