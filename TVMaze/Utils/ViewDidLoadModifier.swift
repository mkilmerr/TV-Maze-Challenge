//
//  ViewDidLoadModifier.swift
//  TVMaze
//
//  Created by longarinas on 08/01/25.
//

import SwiftUI

struct ViewDidLoadModifier: ViewModifier {
    @State private var viewDidLoad: Bool = false
    let perform: (() async -> ())?
    
    func body(content: Content) -> some View {
        content
            .task {
                if !viewDidLoad {
                    viewDidLoad.toggle()
                    await perform?()
                }
            }
    }
}

extension View {
    func onViewDidLoad(perform: (() async -> ())? = nil) -> some View {
        self.modifier(ViewDidLoadModifier(perform: perform))
    }
}
