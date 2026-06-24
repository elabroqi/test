# Test App

An example SwiftUI iOS app that displays movie metadata / media and includes a tiny Python static file server used for local assets. The project demonstrates three things:

- A SwiftUI frontend (Test_App) that uses AVPlayer for video playback and TheMovieDB (TMDB) for metadata.
- Low-level POSIX socket usage from Swift (ClientToServer.swift) showing how to open a TCP socket, build a sockaddr_in, and connect to a server.
- A minimal Python-based static HTTP server (App_Project/Server) that serves files from an images/ directory on port 9000. A Dockerfile is included to package that server.

This README explains the repository layout, how to run the components, and notes about networking, playback, and testing.

---

## Stack

- Languages: Swift (iOS app), Python (simple static HTTP server), Dockerfile
- Frameworks / Runtimes: SwiftUI, AVKit / AVFoundation, Python 3.11 standard library http.server

---

## Repository structure

```
App_Project/
  Server/                      Python static file server + Dockerfile
    server.py                   Simple HTTP file server serving ./images on port 9000
    Dockerfile                  Python image, copies server.py and images/, EXPOSE 9000
    images/                     (place local image/video files here for testing)
  Test_App/                    SwiftUI iOS app (Xcode project)
    Constants.swift            App constants (strings, TMDB apiKey, baseAPIURL, public image URLs)
    FetchData.swift            Data fetching helpers (TMDB integration)
    HomeView.swift             UI: home screen
    HorizontalListView.swift   UI: horizontal lists of movies
    Movie.swift                Movie model
    MovieData.swift            Movie data/provider
    Networking/
      ClientToServer.swift     POSIX-style TCP client (socket, connect, close)
    VideoPlayerView.swift      Uses AVPlayer to play media from a URL
    Test_App.xcodeproj         Xcode project files
```

---

## What this app does (brief)

- The app fetches movie metadata (the repo contains a TMDB API key constant) and displays lists and details in SwiftUI views.
- Media playback uses AVPlayer with a URL (VideoPlayerView.swift). AVPlayer handles streaming, adaptive playback (HLS) and seeking if the server supports HTTP Range requests.
- ClientToServer.swift demonstrates low-level TCP/socket connection steps (socket(), inet_pton(), connect(), close()) and shows how a sockaddr_in is built with an IP + port (9000).
- The Python server is a local static HTTP server that serves files from App_Project/Server/images on port 9000 and is mainly for local testing of assets.

---

## How to run the local image/video server

From the repo root you can either run the Python server directly or with Docker.

Run directly with Python (fast for development):

```bash
cd App_Project/Server
python server.py
```

This will print "Serving images on port 9000" and serve files under the `images/` directory. Example: if you add `sample.mp4` to `App_Project/Server/images/`, it will be available at:

- http://127.0.0.1:9000/sample.mp4

Run with Docker (containerized):

```bash
cd App_Project/Server
docker build -t imageserver .
docker run -p 9000:9000 imageserver
```

Notes:
- On the iOS Simulator, `http://127.0.0.1:9000/...` points to your Mac and will work for testing.
- On a physical device, `127.0.0.1` refers to the device itself; use your machine's LAN IP (e.g. `http://192.168.1.42:9000/sample.mp4`) and ensure the host firewall allows incoming connections and Docker port mapping is configured.

---

## How the networking pieces fit together

- ClientToServer.swift shows how to manually create a TCP connection by:
  1. Calling `socket(AF_INET, SOCK_STREAM, 0)` to create a TCP socket.
  2. Building a `sockaddr_in` with `sin_family = AF_INET`, `sin_port = UInt16(9000).bigEndian`, and `inet_pton` to set `sin_addr`.
  3. Calling `connect(fd, sockaddrPtr, size)` to establish the TCP connection.
  4. Calling `close(fd)` when done.

- The Python server speaks HTTP over TCP. To actually fetch files from it using raw sockets you must speak HTTP on that socket (send a GET request and parse the HTTP response). The repository's Swift socket example currently performs the connection steps but does not (by itself) send an HTTP request — the app uses AVPlayer for media playback which expects a proper HTTP URL.

- AVPlayer (used in VideoPlayerView.swift) takes a URL and performs HTTP requests itself (including range requests for seeking). This is the recommended approach for playing remote media on iOS unless you have a specific need for a custom protocol.

---

## Playing media from the local Python server

1. Place a media file (e.g., `sample.mp4`) in `App_Project/Server/images/`.
2. Start the Python server (see above).
3. In the app (Simulator), open the player with `videoURL` set to `"http://127.0.0.1:9000/sample.mp4"`.

If playback fails to seek or perform partial downloads, the issue may be that the server does not fully support HTTP Range requests. For reliable seeking and progressive playback use a server that supports byte ranges or host content via a proper streaming format (HLS .m3u8) for best compatibility with AVPlayer.

---

## Development notes / suggestions

- Prefer using `URLSession` + `AVPlayer` (or direct AVPlayer URL) for fetching and playing remote media rather than hand-rolling HTTP over raw sockets unless you need a custom protocol.
- If you need to support seeking from AVPlayer against the local server, use a server that supports HTTP Range requests (for example nginx or a small web framework that implements ranges), or implement Range handling in the Python server.
- If you want an example that performs an HTTP GET over your existing socket code and returns the response body, I can add a small `SocketHTTPClient.swift` to the repo for testing.

---

## Next steps I can do for you

- Add a short example file that performs a raw-socket HTTP GET and returns the body for testing.
- Add a NetworkVideoPlayer view that demonstrates pointing AVPlayer at the local server URL.
- Replace or remove the embedded TMDB API key and provide instructions for adding your own via Xcode scheme/env.

---

## License

No license is provided in this repository. Add a LICENSE file if you want to set a license.
