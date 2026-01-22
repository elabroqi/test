//
//  HorizontalListView.swift
//  Test_App
//
//  Created by Temp User on 1/2/26.
//

import SwiftUI

struct HorizontalListView: View {
    
    let header: String
    let movies: [Movie]
    // [Movie] --> type
    // movies --> array
    
    var body: some View {
        VStack(alignment: .leading) {
            
            //text section
            Text(header)
                .font(.title)
                .padding(.top, 20)
            
            //scroll section
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(movies) { movie in
                        NavigationLink {
                            VideoPlayerView(videoURL: movie.videoURL)
                        } label: {
                            AsyncImage(url: URL(string: movie.posterURL)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 120, height: 200) // ✅ MOVE HERE
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .shadow(radius: 4)
                                    .contentShape(Rectangle())
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 120, height: 200)
                            }
                        }
                        .buttonStyle(.plain) // ✅ IMPORTANT inside ScrollView
                    }
                    //inital poster start from horizontal
                    .padding(.horizontal)
                }
            }
            
            // phone edges section
            .padding(.horizontal, 10)
            //.padding(.bottom, 250)
            //.padding(.top, 240)
            
        }
    }
}
#Preview {
    HorizontalListView(header: Constants.topRatedMovieString, movies: movies)
}
