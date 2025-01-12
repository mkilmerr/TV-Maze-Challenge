//
//  PeopleListView.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import SwiftUI

struct PeopleSearchView: View {
    @State private var openPersonWebView: Bool = false
    @State private var searchText: String = ""
    @StateObject private var viewModel: PeopleSearchViewModel

    init(viewModel: PeopleSearchViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                TextField("Search people...", text: $searchText)
                    .bold()
                    .textFieldStyle(.automatic)
                    .autocorrectionDisabled()
                    .padding()
                    .onChange(of: searchText) { _, query in
                        Task {
                            await viewModel.search(by: query)
                        }
                    }

                ZStack {
                    peopleList(viewModel.people)
                    searchResult()
                }
            }
            .navigationTitle("People")
        }
        .sheet(isPresented: $openPersonWebView) {
            if let personSelected = viewModel.personSelected {
                SafariWebView(urlString: personSelected.url)
                    .presentationDragIndicator(.visible)
            }
        }
    }
    
    private func searchResult() -> some View {
        VStack {
            if viewModel.people.isEmpty && searchText.isEmpty {
                Text("Let's search for people!")
                  
            } else if viewModel.people.isEmpty && !searchText.isEmpty {
                HStack {
                    Text("No people found")
                    Image(systemName: "person.2.slash")
                }
            }
        }
        .bold()
        .font(.title)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func peopleList(_ search: [PersonSearched]) -> some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(search, id: \.person.id) { search in
                    PersonSectionView(person: search.person) { person in
                        viewModel.personSelected = person
                        openPersonWebView.toggle()
                    }
                }

                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding()
                }
            }
            .padding()
        }
    }
}

#Preview {
    PeopleSearchView(
        viewModel: PeopleSearchViewModel(
            fetchPeopleUseCase: FetchPeopleUseCaseMock()
        )
    )
}
