//
//  PeopleDetailView.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import SwiftUI

struct PeopleDetailView: View {
    @StateObject private var viewModel: PeopleDetailViewModel

    init(viewModel: PeopleDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            Text("")
        }
        .task {
            await viewModel.loadGuestCastCredit()
        }
    }
}

//#Preview {
//    PeopleDetailView()
//}
