//
//  VideoPlayerView.swift
//  Test_App
//
//  Created by Temp User on 1/4/26.
//

import SwiftUI
import AVKit
import AVFoundation


func configureAudio() {
    let session = AVAudioSession.sharedInstance()
    
    do {
        try session.setCategory(.playback, mode: .moviePlayback)
        try session.setActive(true)
        print("Audio Session Active")
    } catch {
        print("Audio Session error:", error)
    }
}

struct VideoPlayerView: View {
    let videoURL: String
    @State private var player: AVPlayer?
    
    //initalizing a video player
    init(videoURL: String) {
        self.videoURL = videoURL
        self.player = AVPlayer(url: URL(string: videoURL)!)
    }
    
    var body: some View {
        VideoPlayer(player: player)
            .ignoresSafeArea()
            .onAppear {
                configureAudio()
                player?.play()
            }
            .onDisappear {
                player?.pause()
            }
        
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    VideoPlayerView(
        videoURL: movies.first!.videoURL
    )
}
