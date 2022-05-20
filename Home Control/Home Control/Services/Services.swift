//
//  Services.swift
//  Home Control
//
//  Created by Konstantin Zyrianov on 2022-02-20.
//

import Foundation

protocol Services {
    var storage: Storage { get }
}

struct ServiceConfiguration: Services {
    let storage: Storage
}

extension ServiceConfiguration {
    static var memory: ServiceConfiguration {
        ServiceConfiguration(
            storage: MemoryStorage()
        )
    }
}
