//
//  TVMazeApp.swift
//  TVMaze
//
//  Created by longarinas on 08/01/25.
//

import SwiftUI

@main
struct TVMazeApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                TVShowsListView.make()
                    .tabItem {
                        Label("Shows", systemImage: "tv")
                    }
                
                PeopleListView.make()
                    .tabItem {
                        Label("People search", systemImage: "magnifyingglass")
                    }
            }
        }
    }
}


