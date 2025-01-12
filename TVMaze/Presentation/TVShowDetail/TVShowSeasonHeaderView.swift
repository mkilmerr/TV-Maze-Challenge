//
//  TVShowSeasonHeaderView.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import SwiftUI

struct TVShowSeasonHeaderView: View {
    let seasonEpisodes: EpisodeItemViewModel
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button(action: { isExpanded.toggle() }) {
                HStack {
                    Text("Season \(seasonEpisodes.seasonNumber)")
                        .font(.headline)
                    
                    Text("(\(seasonEpisodes.episodes.count) episodes)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                }
            }
            
            if isExpanded {
                ForEach(seasonEpisodes.episodes, id: \.id) { episode in
                    EpisodeRowView(episode: episode)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
        .padding(.horizontal)
        .tint(.accentColor)
        .animation(.easeInOut, value: isExpanded)
    }
}

#Preview {
    TVShowSeasonHeaderView(
        seasonEpisodes: EpisodeItemViewModel.mock()
    )
}
