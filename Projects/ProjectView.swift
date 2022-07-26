//
//  ProjectView.swift
//  Projects
//
//  Created by Robert Nash on 26/06/2021.
//

import SwiftUI
import Directory

struct ProjectView: View {
    
    @State private var isPresented = false
    
    let name: String
    @State private var error: String = "No Error found"
    
    @StateObject var store: PhotosDirectory<Project>
    
    var body: some View {
        VStack {
            Text(name)
            Text(error)
            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())],
                content: {
                    ForEach(store.records) { photo in
                        Image(
                            uiImage: try! photo.read()!
                        )
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    }
                    .padding(.vertical)
                })
        }
        .onAppear(perform: {
//            photos.loadAndWait()
            Task {
                try! await store.load()
            }
        })
        .navigationBarItems(trailing: button)
        .sheet(isPresented: $isPresented, content: {
            ImagePicker() { image in
                // we don't care too much about the tribulations of picking an image in this demo.
                if let data = image?.pngData() {
                    try! store.append(data: data)
//                    try! store.insert(data)
                    self.error = "No Error found"
                } else {
                    self.error = "There is a problem with that image. Please select another."
                }
                isPresented = false
            }
        })
    }
    
    private var button: some View {
        Button(action: {
            isPresented = true
        }, label: {
            Text("Button")
        })
    }
}

//   alternatively
//   private var temps: [TempPhoto]

/// temp photos are stored in temp directory
/// so you can ignore them and discard array
/// or...

//    photos.insert(temps: temps)

struct ProjectView_Previews: PreviewProvider{

    static var person = Person(name: "Rob")
    
    static var project = Project(name: "Project 1", person: person)
    
    static var previews: some View {
        
        return NavigationView {
            ProjectView(name: project.name, store: project.photos)
        }
    }
}
