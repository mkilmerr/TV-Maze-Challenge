//
//  TVShowDetailView.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import SwiftUI

struct TVShowDetailView: View {
    @StateObject private var viewModel: TVShowDetailViewModel
    
    init(show: TVShow) {
        let useCase = FetchTVShowEpisodesUseCase(repository: TVShowEpisodesRepository(networkClient: .init()))
        _viewModel = StateObject(wrappedValue: TVShowDetailViewModel(
            fetchEpisodesUseCase: useCase,
            show: show
        ))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                showInfoSection
                seasonsList
            }
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
                    Text(summary)
                        .font(.body)
                }
                
                HStack {
                    Text("Status: \(viewModel.show.status)")
                        .font(.subheadline)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
                    
                    if let rating = viewModel.show.rating.average {
                        Text("Rating: ★ \(String(format: "%.1f", rating))")
                            .font(.subheadline)
                            .foregroundColor(.yellow)
                    }
                }
                
                if !viewModel.show.genres.isEmpty {
                    Text("Genres: \(viewModel.show.genres.joined(separator: ", "))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Text("Schedule: \(viewModel.show.schedule.days.joined(separator: ", ")) at \(viewModel.show.schedule.time)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
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
                    ExpandableSeasonCard(seasonEpisodes: seasonEpisodes)
                }
            }
        }
        .padding(.top)
    }
}

struct ExpandableSeasonCard: View {
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
                        .foregroundColor(.blue)
                }
            }
            
            if isExpanded {
                ForEach(seasonEpisodes.episodes, id: \.id) { episode in
                    EpisodeRow(episode: episode)
                        .transition(.opacity)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
        .padding(.horizontal)
        .animation(.easeInOut, value: isExpanded)
    }
}

struct EpisodeRow: View {
    let episode: Episode
    
    var body: some View {
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
                Text(summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression))
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            
            Text("Aired: \(episode.airdate)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    TVShowDetailView(show: TVShow.mockShows().first!)
}
