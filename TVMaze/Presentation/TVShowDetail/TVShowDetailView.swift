//
//  TVShowDetailView.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import SwiftUI

struct TVShowDetailView: View {
    @StateObject private var viewModel: TVShowDetailViewModel
    
    init(viewModel: TVShowDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                showInfoSection
                seasonsList
            }
            .padding(.top, 8)
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadSeasons()
        }
    }
    
    private var showInfoSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let imageUrl = viewModel.show.image?.original {
                RemoteImage(url: URL(string: imageUrl), size: .big)
                    .aspectRatio(contentMode: .fit)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.show.name)
                    .font(.title)
                    .bold()
                
                if let summary = viewModel.show.summary {
                    Text(summary.removeHTML())
                        .font(.body)
                }
                subHeader()
            }
            .padding()
        }
    }
    
    private func subHeader() -> some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Pill(
                            text: "Status: \(viewModel.show.status)",
                            color: .blue
                        )

                        Spacer()

                        if let rating = viewModel.show.rating.average {
                            Text("Rating: ★ \(String(format: "%.1f", rating))")
                                .bold()
                                .foregroundColor(.yellow)
                        }
                    }
                   

                    if !viewModel.show.genres.isEmpty {
                        Pill(
                            text: "Genres: \(viewModel.show.genres.joined(separator: ", "))",
                            color: .green
                        )
                    }
                    
                    Pill(
                        text: "Schedule: \(viewModel.show.schedule.days.joined(separator: ", ")) at \(viewModel.show.schedule.time)",
                        color: .orange
                    )
                }
                Spacer()
            }
        }
        .padding(.top, 16)
    }

    private var seasonsList: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Seasons")
                .font(.title2)
                .bold()
                .padding(.horizontal)
            
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding()
            } else {
                ForEach(viewModel.episodes) { seasonEpisodes in
                    TVShowSeasonHeaderView(seasonEpisodes: seasonEpisodes)
                }
            }
        }
        .padding(.top)
    }
}

//#Preview {
//    TVShowDetailView(viewModel: .)
//    TVShowDetailView(show: TVShow.mockShows().first!)
//}
