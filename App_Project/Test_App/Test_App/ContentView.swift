//
//  ContentView.swift
//  Test_App
//
//  Created by Temp User on 12/27/25.
//

import SwiftUI

struct ContentView: View {
    
    let client = ClientToServer()
    
    var body: some View {
        TabView{
            //text view "____String"
            Tab(Constants.homeString, systemImage: Constants.homeIconString){
                NavigationStack{ //navigtion link needs navigation stack to work 
                    HomeView()
                }
            }
            Tab(Constants.upcomingString, systemImage: Constants.upcomingIconString){
                Text(Constants.upcomingString)
            }
            Tab(Constants.searchString, systemImage: Constants.searchIconString){
                Text(Constants.searchString)
            }
            Tab(Constants.downloadString, systemImage: Constants.downloadIconString){
                Text(Constants.downloadString)
            }
        }
        //when screen loads connect to server
        .onAppear{
            //run on background threads
            DispatchQueue.global().async{
                client.connect()
            }
        }
    }
}

#Preview {
    ContentView()
}
