//
//  TVMazeApp.swift
//  TVMaze
//
//  Created by longarinas on 08/01/25.
//

import SwiftUI
import SwiftData

@main
struct TVMazeApp: App {
    let container: ModelContainer
    @StateObject private var biometricAuthenticationViewModel = BiometricAuthenticationViewModel.make()
    
    init() {
        do {
            container = try ModelContainer(for: TVShowLocalData.self)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                if biometricAuthenticationViewModel.isAuthenticated {
                    TabView {
                        TVShowsListView.make(
                            modelContext: container.mainContext,
                            mode: .defaultList
                        )
                            .tabItem {
                                Label("Shows", systemImage: "tv")
                            }
                        
                        PeopleSearchView.make()
                            .tabItem {
                                Label("People search", systemImage: "magnifyingglass")
                            }
                        
                        TVShowsListView.make(
                            modelContext: container.mainContext,
                            mode: .favorite
                        )
                            .tabItem {
                                Label("Favorites", systemImage: "heart.fill")
                            }
                    }
                    .modelContainer(container)
                } else {
                    BiometricAuthenticationView(
                        viewModel: biometricAuthenticationViewModel
                    )
                }
            }
        }
    }
}
