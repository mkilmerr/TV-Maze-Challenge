//
//  EpisodeDetailView.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import SwiftUI

struct EpisodeDetailView: View {
    let episode: Episode
    
    init(episode: Episode) {
        self.episode = episode
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Text(episode.name)
                    .bold()
                    .font(.title)
                    .padding(.top, 20)

                if let image = episode.image?.original {
                    RemoteImage(url: URL(string: image), size: .small)
                }
                
                if let summary = episode.summary {
                    Text(summary.removeHTML())
                        .bold()
                }
                
                HStack {
                    Pill(
                        text: "Season: \(episode.season)",
                        color: .yellow
                    )
                    Pill(
                        text: "Number: \(episode.number)",
                        color: .red
                    )
                    Spacer()
                }
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .background(Color.background)
    }
}

#Preview {
    EpisodeDetailView(episode: .init(id: 0, url: "", name: "", season: 0, number: 0, type: "", airdate: "", airtime: "", airstamp: "", runtime: 0, rating: .init(average: nil), image: nil, summary: nil, links: .init(linksSelf: .init(href: "", name: nil), previousEpisode: nil))
    )
}
