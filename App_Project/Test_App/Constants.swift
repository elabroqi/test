//
//  Constants.swift
//  Test_App
//
//  Created by Temp User on 12/29/25.
//

import Foundation
import SwiftUI

// allows access across the app
struct Constants{
    // let means the string won't chnge within the program
    static let homeString = "Home"
    static let upcomingString = "Upcoming"
    static let searchString = "Search"
    static let downloadString = "Download"
    
    //buttons
    static let playString = "Play"
    
    //list of horizontal movies + descriptors
    static let allMovieString = "All Movies"
    static let topRatedMovieString = "Top Rated Movies"
    static let fantasyMovieString = "Fantasy Movies" //alice
    static let mysteryMovieString = "Mystery Movies" //sherlock
    static let crimeMovieString = "Crime Movies" //inspector
    
    
    //image names for content viewer
    static let homeIconString = "house"
    static let upcomingIconString = "play.circle"
    static let searchIconString = "magnifyingglass"
    static let downloadIconString = "arrow.down.to.line"
    
    
    //api key
    static let apiKey = "a7e46cf9d4d8846864294269a67d9a7f"
    static let baseAPIURL = "https://api.themoviedb.org/3"
    
    //public images
    static let AliceInWonderlandImage = PublicImage(url: "https://media-cache.cinematerial.com/p/500x/otf5o39z/alice-in-wonderland-movie-cover.jpg?v=1456799535")

    static let SherlockHolmesImage = PublicImage(url:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvmGkbh6kvVQl498m5pKg9Glfn7cqglX7pnQ&s")
    
    static let TheInspectorsImage = PublicImage(url: "https://m.media-amazon.com/images/M/MV5BYWE2NmFjYjQtZWU1Yy00OWYxLWI1NDctMzZiOGZlNjU2YTM5XkEyXkFqcGc@._V1_.jpg")

}

//add functionality to an existing type w/o modifying the original
extension Text {
    func button() -> some View {
        //self matches return type 
        self
            .frame(width: 100, height: 50)
            .foregroundStyle(.buttonText)
            .bold()
            .background{
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(.buttonBorder,lineWidth: 2)
            }
    }
}
