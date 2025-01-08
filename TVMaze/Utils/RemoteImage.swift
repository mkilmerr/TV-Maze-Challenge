//
//  RemoteImage.swift
//  TVMaze
//
//  Created by longarinas on 08/01/25.
//

import SwiftUI

struct RemoteImage: View {
    let url: URL?
    
    init(url: URL?) {
        self.url = url
    }

    var body: some View {
        if let url {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 300, height: 200)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                        .frame(width: 300, height: 200)
                    
                case .failure(_):
                    placeHolder()
                @unknown default:
                    EmptyView()
                }
            }
        } else {
            placeHolder()
        }
    }
    
    private func placeHolder() -> some View {
        Image(systemName: "photo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300, height: 200)
            .foregroundColor(.gray)
    }
}

#Preview {
    RemoteImage(url: nil)
}
