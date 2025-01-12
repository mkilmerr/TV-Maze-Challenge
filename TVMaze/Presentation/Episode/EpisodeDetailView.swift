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
    EpisodeDetailView(episode: Episode.mock())
}
