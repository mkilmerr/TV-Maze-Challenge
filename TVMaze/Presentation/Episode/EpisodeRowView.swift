//
//  EpisodeRowView.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import SwiftUI

struct EpisodeRowView: View {
    @State private var openEpisodeDetail: Bool = false
    let episode: Episode
    
    var body: some View {
        VStack {
            Button {
                openEpisodeDetail.toggle()
            } label: {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("\(episode.number). \(episode.name)")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        Spacer()
                        
                        if let rating = episode.rating.average {
                            Text("★ \(String(format: "%.1f", rating))")
                                .font(.subheadline)
                                .foregroundColor(.yellow)
                        }
                    }
                    
                    if let summary = episode.summary {
                        Text(summary.removeHTML())
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .sheet(isPresented: $openEpisodeDetail) {
            EpisodeDetailView(episode: episode)
                .presentationDragIndicator(.visible)
        }
    }
}


#Preview {
    EpisodeRowView(episode: .init(id: 0, url: "", name: "", season: 0, number: 0, type: "", airdate: "", airtime: "", airstamp: "", runtime: 0, rating: .init(average: nil), image: nil, summary: nil, links: .init(linksSelf: .init(href: "", name: nil), previousEpisode: nil))
    )
}
