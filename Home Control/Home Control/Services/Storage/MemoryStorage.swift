//
//  MemoryStorage.swift
//  Home Control
//
//  Created by Konstantin Zyrianov on 2022-02-19.
//

import Foundation

final class MemoryStorage: Storage {
    private var records: [ObjectIdentifier: [Any]] = [:]

    func getObjects<Record: RecordBase>() -> [Record] {
        (records[ObjectIdentifier(Record.self), default: []] as? [Record]) ?? []
    }

    func store<Record: RecordBase>(record: Record) async throws {
        var records = (self.records[ObjectIdentifier(Record.self), default: []] as? [Record]) ?? []
        records.removeAll(where: { $0.id == record.id })
        records.append(record)
        self.records[ObjectIdentifier(Record.self)] = records
    }

    func delete<Record: RecordBase>(record: Record) async throws {
        var records = (self.records[ObjectIdentifier(Record.self), default: []] as? [Record]) ?? []
        records.removeAll(where: { $0.id == record.id })
        self.records[ObjectIdentifier(Record.self)] = records
    }
}
