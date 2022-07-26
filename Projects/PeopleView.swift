//
//  PeopleView.swift
//  Projects
//
//  Created by Robert Nash on 23/07/2022.
//

import SwiftUI
import Directory

struct PeopleView: View {
    
    @StateObject var store: Directory<Person>
    
    var body: some View {
        List {
            ForEach(store.records) { person in
                NavigationLink(person.name, destination: destination(person))
            }
        }
        .padding()
        .navigationTitle("People")
        .navigationBarItems(trailing: button)
        .onAppear(perform: {
            try! store.loadAndWait()
        })
    }
    
    func delete(at offsets: IndexSet) {
        if let index = offsets.first {
            try! store.delete(at: index)
        }
    }
    
    private var button: some View {
        Button(action: {
            addPerson()
        }, label: {
            Image(systemName: "plus")
        })
    }
    
    private func destination(_ person: Person) -> some View {
        ProjectsView(person: person, store: Directory<Project>(container: person))
    }
    
    private func addPerson() {
        let person = Person(name: "Person_" + UUID().uuidString)
        try! store.append(person)
    }
}

struct PeopleView_Previews: PreviewProvider {
    
    static var previews: some View {
        Person.root = .temp
        return PeopleView(store: try! Directory<Person>())
    }
}
