//
//  Global.swift
//  Piazza
//
//  Created by Sean Wymer on 6/18/24.
//

import Foundation
import Turbo

struct Global {
    static let pathConfiguration = PathConfiguration(
        sources:
            [
                .file(
                    Bundle.main.url(
                        forResource: "path_configuration",
                        withExtension: "json"
                    )!)
            ]
    )
}
