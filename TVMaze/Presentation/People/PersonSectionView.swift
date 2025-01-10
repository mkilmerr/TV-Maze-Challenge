//
//  PersonSectionView.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import SwiftUI

struct PersonSectionView: View {
    let person: Person
    let action: ((Person) -> ())?

    init(
        person: Person,
        action: @escaping (Person) -> Void
    ) {
        self.person = person
        self.action = action
    }

    var body: some View {
        Button {
            action?(person)
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    if let image = person.image?.medium {
                        HStack {
                            RemoteImage(url: URL(string: image), size: .circular)
                            Spacer()
                        }
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        Spacer()
                    }
                    
                    Text(person.name)
                        .bold()
                        .font(.title2)
                }
            }
            .padding()
        }
    }
}

//#Preview {
//    PersonSectionView()
//}
