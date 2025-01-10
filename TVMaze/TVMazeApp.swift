//
//  TVMazeApp.swift
//  TVMaze
//
//  Created by longarinas on 08/01/25.
//

import SwiftUI

@main
struct TVMazeApp: App {
    @StateObject private var biometricAuthenticationViewModel = BiometricAuthenticationViewModel.make()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if biometricAuthenticationViewModel.isAuthenticated {
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
                } else {
                    BiometricAuthenticationView(
                        viewModel: biometricAuthenticationViewModel
                    )
                }
            }
        }
    }
}

