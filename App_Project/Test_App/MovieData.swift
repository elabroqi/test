//
//  MovieData.swift
//  Test_App
//
//  Created by Temp User on 1/2/26.
//



import Foundation

//fixed list of moveis so we use "let"
let movies: [Movie] = [
    Movie(
        title: "Alice in Wonderland (1915)",
        posterURL: Constants.AliceInWonderlandImage.url,
        videoURL: "http:10.37.58.220:8000/alice_ios.mp4",
        genre: ["Fantasy Movies", "Trending Movies", "All Movies"]
    ),
    Movie(
        title: "Sherlock Holmes Faces Death",
        posterURL: Constants.SherlockHolmesImage.url,
        videoURL: "http://10.37.58.220:8000/sherlock_ios.mp4",
        genre: ["Mystery Movies", "All Movies"]
    ),
    Movie(
        title: "The Inspectors",
        posterURL: Constants.TheInspectorsImage.url,
        videoURL: "http://10.37.58.220:8000/inspector_ios.mp4",
        genre: ["Crime Movies", "Top Rated Movies", "All Movies"]
    )
]
