//
//  FavoriteTVShowsView.swift
//  TVMaze
//
//  Created by longarinas on 11/01/25.
//

import SwiftUI

struct FavoriteTVShowsView: View {
    @Environment(\.modelContext) private var modelContext
   
    var body: some View {
        VStack {
            
        }
        .onAppear {
            var localDataManager = LocalDataManager<TVShowLocalData>(context: modelContext)
            localDataManager.fetchAll()
            
        }
    }
}

#Preview {
    FavoriteTVShowsView()
}
