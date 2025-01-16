//
//  ShadiDotComApp.swift
//  ShadiDotCom
//
//  Created by Rohit on 15/01/25.
//

import SwiftUI

@main
struct ShadiDotComApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            UserListView()
        }
    }
}
