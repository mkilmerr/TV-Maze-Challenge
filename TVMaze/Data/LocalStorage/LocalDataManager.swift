//
//  LocalDataManager.swift
//  TVMaze
//
//  Created by longarinas on 11/01/25.
//

import Foundation
import SwiftData
import SwiftUI

@MainActor
@Observable
final class LocalDataManager<T: PersistentModel> {
    private(set) var container: ModelContainer?
    let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
        do {
            container = try ModelContainer(for: T.self)
        } catch {
            print("Failed to create ModelContainer: \(error.localizedDescription)")
        }
    }

    func fetchAll() -> [T] {
        let descriptor = FetchDescriptor<T>()

        do {
            return try context.fetch(descriptor)
        } catch {
            print("Failed to fetch shows: \(error.localizedDescription)")
            return []
        }
    }
    
    func save(_ show: T) {
        do {
            let items = fetchAll().filter { $0 == show }
            if items.isEmpty {
                context.insert(show)
            } else {
                delete(show)
            }

            try context.save()
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
        }
    }

    func delete(_ tvShow: T) {
        do {
            context.delete(tvShow)
            try context.save()
        } catch {
            print("Failed to delete show: \(error.localizedDescription)")
        }
    }
}
