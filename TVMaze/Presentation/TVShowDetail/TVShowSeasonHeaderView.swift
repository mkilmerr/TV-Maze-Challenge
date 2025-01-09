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
    TVShowSeasonHeaderView(seasonEpisodes: .init(seasonNumber: 0, episodes: [.init(id: 0, url: "", name: "", season: 0, number: 0, type: "", airdate: "", airtime: "", airstamp: "", runtime: 0, rating: .init(average: 0), image: nil, summary: nil, links: .init(linksSelf: .init(href: "", name: nil), previousEpisode: nil))]))
}
