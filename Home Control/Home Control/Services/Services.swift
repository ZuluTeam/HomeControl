//
//  Services.swift
//  Home Control
//
//  Created by Konstantin Zyrianov on 2022-02-15.
//

import Foundation

struct ServiceConfiguration {
    let storage: Storage
}

protocol StorageFactory {
    var storage: Storage { get }
}

extension ServiceConfiguration: StorageFactory {}
