//
//  String+RemoveHTML.swift
//  TVMaze
//
//  Created by longarinas on 09/01/25.
//

import Foundation

extension String {
    func removeHTML() -> String {
        self.replacingOccurrences(
            of: "<[^>]+>", with: "",
            options: .regularExpression
        )
    }
}
