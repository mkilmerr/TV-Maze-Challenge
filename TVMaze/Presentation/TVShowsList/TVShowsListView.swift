//
//  TVShowsListView.swift
//  TVMaze
//
//  Created by longarinas on 08/01/25.
//

import SwiftUI

struct TVShowsListView: View {
    @StateObject private var viewModel: TVShowsListViewModel

    init(viewModel: TVShowsListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            VStack {
                showsList(viewModel.tvShows)
            }
            .navigationTitle("TV Shows")
            .onViewDidLoad {
                await viewModel.loadTVShows()
            }
        }
    }
    
    private func showsList(_ shows: [TVShow]) -> some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(shows, id: \.id) { show in
                    showRow(for: show)
                        .contentShape(Rectangle())
                        .task(id: show.id) {
                            if show.id == shows.last?.id {
                                await viewModel.loadTVShows()
                            }
                        }
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                
                if !viewModel.tvShows.isEmpty {
                    Text("Fetching more...")
                        .task {
                            await viewModel.loadTVShows()
                        }
                }
            }
            .padding()
        }
    }

    private func showRow(for show: TVShow) -> some View {
        NavigationLink {
            TVShowDetailView.make(with: show)
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                Text(show.name)
                    .bold()
                    .font(.largeTitle)
                
                if let image = show.image?.original {
                    HStack {
                        RemoteImage(url: URL(string: image))
                        Spacer()
                    }
                   
                }
                
                if let summary = show.summary {
                    Text(summary.removeHTML())
                        .font(.headline)
                        .lineLimit(2)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text(show.status)
                        .font(.caption)
                        .padding(4)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(4)
                    
                    if let rating = show.rating.average {
                        Text("★ \(String(format: "%.1f", rating))")
                            .font(.caption)
                            .foregroundColor(.yellow)
                    }
                }
            }
            .padding(.vertical, 4)
        }
    }
}

#Preview {
    TVShowsListView(
        viewModel: .init(
            fetchTVShowsUseCase: FetchTVShowsUseCaseMock()
        )
    )
}
