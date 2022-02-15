//
//  ProductionServiceConfiguration.swift
//  Home Control
//
//  Created by Konstantin Zyrianov on 2022-02-15.
//

import Foundation

extension ServiceConfiguration {
    static let prod: ServiceConfiguration = {
        ServiceConfiguration(
            storage: ProductionStorage()
        )
    }()
}
