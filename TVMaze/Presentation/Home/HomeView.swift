//
//  HomeView.swift
//  TVMaze
//
//  Created by longarinas on 08/01/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    @State private var navigationState: NavigationState?

    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            VStack {
                showsList(viewModel.tvShows)
            }
            .navigationTitle("TV Shows")
            .navigationDestination(isPresented: .init(
                get: { navigationState != nil },
                set: { if !$0 { navigationState = nil } }
            )) {
                if case .detail(let show) = navigationState {
                   // ShowDetailView(show: show)
                }
            }
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
                        .onTapGesture {
                            navigationState = .detail(show)
                        }
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
        VStack(alignment: .leading, spacing: 8) {
            Text(show.name)
                .font(.title)
            
            if let image = show.image?.medium {
                RemoteImage(url: URL(string: image))
            }
            
            if let summary = show.summary {
                Text(summary)
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

// MARK: - Preview Helpers
enum NavigationState {
    case detail(TVShow)
}

final class FetchTVShowsUseCaseMock: FetchTVShowsUseCaseProtocol {
    func execute(page: Int) async throws -> [TVShow] {
        TVShow.mockShows()
    }
}

#Preview {
    HomeView(viewModel: .init(fetchTVShowsUseCase: FetchTVShowsUseCaseMock()))
}
