//
//  ProjectsApp.swift
//  Projects
//
//  Created by Robert Nash on 26/06/2021.
//

import SwiftUI
import Directory

@main
struct ProjectsApp: App {
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(store: establishStore())
            }
        }
    }
    
    private func establishStore() -> Directory<Project> {
        do {
            return try Directory<Project>()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
