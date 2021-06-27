//
//  ContentView.swift
//  Projects
//
//  Created by Robert Nash on 26/06/2021.
//

import SwiftUI
import Directory

struct ContentView: View {
    
    @StateObject var store: Directory<Project>
    
    var body: some View {
        List {
            ForEach(store.fetchedItems) { project in
                NavigationLink(
                    project.name,
                    destination: ProjectView(
                        name: project.name,
                        photos: project.photos
                    )
                )
            }
        }
        .padding()
        .navigationTitle("Projects")
        .navigationBarItems(trailing: button)
        .onAppear(perform: {
            store.fetch(.async(.global(qos: .userInitiated)))
        })
    }
    
    private var button: some View {
        Button(action: {
            addProject()
        }, label: {
            Image(systemName: "plus")
        })
    }
    
    private func addProject() {
        do {
            let project = try Project(name: "Project " + UUID().uuidString)
            try! store.append(project)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView(store: try! Directory<Project>(isPreview: true))
        }
    }
}
