//
//  Title.swift
//  Test_App
//
//  Created by Temp User on 1/2/26.
//

import Foundation

//need to assign a unique id for each movie with Identifiable 
struct Movie: Identifiable {
    let id: UUID = UUID()
    let title: String
    let posterURL: String
    let videoURL: String
    let genre: [String] //need to filter since there are diff titles 
}
