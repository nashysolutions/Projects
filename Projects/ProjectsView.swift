//
//  ProjectsView.swift
//  Projects
//
//  Created by Robert Nash on 26/06/2021.
//

import SwiftUI
import Directory

struct ProjectsView: View {
    
    let person: Person
    
    @StateObject var store: Directory<Project>
    
    var body: some View {
        List {
            ForEach(store.records) { project in
                NavigationLink(
                    project.name,
                    destination: destination(project)
                )
            }
            .onDelete(perform: delete)
        }
        .padding()
        .navigationTitle("Projects")
        .navigationBarItems(trailing: button)
        .onAppear(perform: {
            try! store.loadAndWait()
        })
    }
    
    private func destination(_ project: Project) -> some View {
        ProjectView(name: project.name, store: project.photos)
    }
    
    func delete(at offsets: IndexSet) {
        if let index = offsets.first {
            try! store.delete(at: index)
        }
    }
    
    private var button: some View {
        Button(action: {
            addProject()
        }, label: {
            Image(systemName: "plus")
        })
    }
    
    private func addProject() {
        let project = Project(name: "Project " + UUID().uuidString, person: person)
        try! store.append(project)
    }
}

struct ProjectsView_Previews: PreviewProvider {
    
    static var person = Person(name: "Rob")
    
    static var store: Directory<Project> {
        Directory<Project>(container: person)
    }
    
    static var previews: some View {
        NavigationView {
            ProjectsView(person: person, store: store)
        }
    }
}
