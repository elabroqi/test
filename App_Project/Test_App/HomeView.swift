//
//  HomeView.swift
//  Test_App
//
//  Created by Temp User on 12/29/25.
//

//building a screen
import SwiftUI

//define the screen
struct HomeView: View {

    //fixed image on the top of this screen
    let movieImage = Constants.AliceInWonderlandImage
    
    //movie section
    let sections: [String] = [
        Constants.allMovieString,
        Constants.topRatedMovieString,
        Constants.fantasyMovieString,
        Constants.mysteryMovieString,
        Constants.crimeMovieString
    ]
    
    //body of screen
    var body: some View {
        //vertical scroll and size reltive to the device
        GeometryReader { geo in
            ScrollView{
                LazyVStack {
                    //load fixed image and add properties for sizing
                    AsyncImage(url: URL(string: movieImage.url)) { image in
                        image
                        //using modifiers to change the view
                            .resizable()
                            .scaledToFit()
                            .overlay{
                                //view in front of the main image
                                LinearGradient(
                                    stops: [Gradient.Stop(color: .clear, location: 0.85), Gradient.Stop(color:
                                            .gradient, location:  1)],
                                    //direction of the gradient from top to bottom clear 85%, 15% gradient
                                    startPoint: .top,
                                    endPoint: .bottom)
                            }
                    } placeholder: {
                        //spinner while image loads
                        ProgressView()
                    } // width of screen, calibrting height to only 80%, 20% white
                    .frame(width: geo.size.width, height: geo.size.height * 0.80)
                    
                    HStack {
                        //play button
                        Button{
                        } label: {
                            Text(Constants.playString)
                            //call button style func from constants file
                                .button()
                        }
                        
                        //downlod button 
                        Button{
                        } label: {
                            Text(Constants.downloadString)
                                .button()
                        }
                    }
                    
                    // Movie Poster Sections
                    ForEach(sections, id: \.self){ section in
                        //create horizontal view w section title + movie that matches that title
                        HorizontalListView(header: section,
                                           movies: movies.filter { movie in
                            movie.genre.contains(section)
                        }
                        )
                    }
                }
            }
        }
    }
}


#Preview {
    HomeView()
}
