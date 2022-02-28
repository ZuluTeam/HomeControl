//
//  CloudStorage.swift
//  Home Control
//
//  Created by Konstantin Zyrianov on 2022-02-15.
//

import Foundation

final class CloudStorage: Storage {
    func getObjects<Record: RecordBase>() -> [Record] {
        fatalError("Needs to be implemented")
    }

    func store<Record: RecordBase>(record: Record) async throws {
        fatalError("Needs to be implemented")
    }

    func delete<Record: RecordBase>(record: Record) async throws {
        fatalError("Needs to be implemented")
    }

}
