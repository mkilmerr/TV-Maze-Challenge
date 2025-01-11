//
//  PeopleDetailView.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import SwiftUI

struct PeopleDetailView: View {
    let person: Person

    init(person: Person) {
        self.person = person
    }

    var body: some View {
        VStack {
            PersonSectionView(
                person: person,
                isTapEnabled: false
            ) { person in
              
            }
            .padding(.top, 16)
            
            Spacer()
        }
        .background(Color.background)
    }
}

//#Preview {
//    PeopleDetailView()
//}
