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
                PeopleView(store: try! Directory<Person>())
            }
        }
    }
}
