//
//  RemoteImage.swift
//  TVMaze
//
//  Created by longarinas on 08/01/25.
//

import SwiftUI

extension RemoteImage {
    enum Size {
        case small
        case big
    }
}

struct RemoteImage: View {
    let url: URL?
    let size: Self.Size
    
    init(url: URL?, size: Self.Size = .small) {
        self.url = url
        self.size = size
    }

    var body: some View {
        VStack {
            if let url {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 300, height: 200)

                    case .success(let image):
                        getImage(by: size, remoteImage: image)

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
    }
    
    private func placeHolder() -> some View {
        Image(systemName: "photo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 100)
            .foregroundColor(.gray)
    }
    
    private func getImage(by size: Self.Size, remoteImage: Image) -> some View {
        VStack {
            switch size {
            case .big:
                remoteImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
            case .small:
                remoteImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
                    .frame(height: 300)


            }
        }
    }
}

#Preview {
    RemoteImage(url: nil)
}
