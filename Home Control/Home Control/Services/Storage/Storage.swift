//
//  Storage.swift
//  Home Control
//
//  Created by Konstantin Zyrianov on 2022-02-15.
//

import Foundation

enum StorageError: Error {
    case unableToStore(Error)
    case unableToDelete(Error)
}

protocol Storage {
    typealias RecordBase = Equatable & Identifiable

    func getObjects<Record: RecordBase>() -> [Record]
    func store<Record: RecordBase>(record: Record) async throws
    func delete<Record: RecordBase>(record: Record) async throws
}
