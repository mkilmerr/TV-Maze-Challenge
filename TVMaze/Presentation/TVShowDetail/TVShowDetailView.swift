//
//  TVShowDetailView.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import SwiftUI
import SwiftData

struct TVShowDetailView: View {
    @StateObject private var viewModel: TVShowDetailViewModel
    @State private var isFavorite: Bool = false
    let descriptor = FetchDescriptor<TVShowLocalData>()
    @Environment(\.modelContext) private var context
    
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
        .onAppear {
            checkFavorite()
        }
        .alert("Something went wrong...", isPresented: $viewModel.isError) {
            Button("OK", role: .cancel) { }
        }
        .task {
            await viewModel.loadEpisodes()
        }
    }
    
    private var showInfoSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let imageUrl = viewModel.show.remoteImage {
                RemoteImage(url: URL(string: imageUrl), size: .big)
                    .aspectRatio(contentMode: .fit)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(viewModel.show.name)
                        .font(.title)
                        .bold()
                    Spacer()
                    Button {
                        saveTVShow()
                    } label: {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .tint(.red)
                    }
                }
                .padding(.bottom, 16)
                .padding(.trailing, 8)
                
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
                        
                        if let rating = viewModel.show.average {
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
                        text: "Schedule: \(String(describing: viewModel.show.scheduleDays?.joined(separator: ", "))) at \(viewModel.show.time)",
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
    
    // MARK: Local Storage
    private func saveTVShow() {
        do {
            let data = try context.fetch(descriptor)
            if data.filter({ $0.id == viewModel.show.id }).isEmpty {
                if let show = viewModel.show as? TVShow {
                    context.insert(show.toLocalData())
                    try context.save()
                    isFavorite = true
                }
            } else {
                removeTVShowFromFavorite()
            }
        } catch {
            isFavorite = false
        }
    }
    
    private func removeTVShowFromFavorite() {
        if let show = viewModel.show as? TVShow {
            do {
                let data = try context.fetch(descriptor)
                if let localShow = data.first(where: { $0.id == show.id }) {
                    context.delete(localShow)
                    try context.save()
                    isFavorite = false
                }
            } catch {
                isFavorite = true
            }
        }
    }
    
    func checkFavorite() {
        do {
            let result = try !context.fetch(descriptor).filter {
                $0.id == viewModel.show.id
            }.isEmpty

            isFavorite =  result
        } catch {
            isFavorite = false
        }
    }
}

#Preview {
    TVShowDetailView(
        viewModel: TVShowDetailViewModel(
            fetchEpisodesUseCase: FetchTVShowSeasonsUseCaseMock(),
            show: TVShow.mockShows()[0])
    )
}

