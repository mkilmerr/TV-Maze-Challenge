//
//  PeopleListView.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import SwiftUI

struct PeopleListView: View {
    @State private var openGuestCastCredits: Bool = false
    @StateObject private var viewModel: PeopleListViewModel

    init(viewModel: PeopleListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            peopleList(viewModel.people)
        }
        .navigationTitle("People")
        .onViewDidLoad {
            await viewModel.loadPeople()
        }
        .sheet(isPresented: $openGuestCastCredits) {
            if let personSelected = viewModel.personSelected {
                PeopleDetailView.make(with: personSelected)
            }
        }
    }
    
    private func peopleList(_ people: [Person]) -> some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(people, id: \.id) { person in
                    PersonSectionView(person: person) { person in
                        viewModel.personSelected = person
                        openGuestCastCredits.toggle()
                    }
                    .task(id: person.id) {
                        if person.id == people.last?.id {
                            await viewModel.loadPeople()
                        }
                    }
                }

                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding()
                }

                if !viewModel.people.isEmpty {
                    Text("Fetching more...")
                        .task {
                            await viewModel.loadPeople()
                        }
                }
            }
            .padding()
        }
    }
}
