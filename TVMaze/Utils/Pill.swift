//
//  Pill.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import SwiftUI

struct Pill: View {
    let text: String
    let color: Color
    
    init(text: String, color: Color) {
        self.text = text
        self.color = color
    }

    var body: some View {
        Text(text)
            .bold()
            .font(.subheadline)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(color.opacity(0.5))
            .cornerRadius(16)
    }
}

#Preview {
    Pill(text: "", color: .blue)
}
