//
//  Api.swift
//  Piazza
//
//  Created by Sean Wymer on 6/18/24.
//

import Foundation

struct Api {
    #if DEBUG
    static let rootURL = URL(string: "http://localhost:3000/")!
    #else
    static let rootURL =
    URL(string: "https://your-domain-here.onrender.com/")!
    #endif
    
    struct Path {
        static let login =
        Api.rootURL.appendingPathComponent("login")
        static let profile =
        Api.rootURL.appendingPathComponent("profile")
    }
}
