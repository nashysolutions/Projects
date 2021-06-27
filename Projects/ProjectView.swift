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
    @StateObject var photos: PhotosDirectory<Project>
    
    var body: some View {
        VStack {
            Text(name)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], content: {
                ForEach(photos.fetchedItems) { photo in
                    Image(uiImage: photo.read()!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .padding(.vertical)
            })
        }
        .onAppear(perform: {
            // this loads the database, not the assets.
            photos.fetch(.sync)
        })
        .navigationBarItems(trailing: button)
        .sheet(isPresented: $isPresented, content: {
            ImagePicker() { image in
                if let data = image?.pngData() {
                    try! photos.insert(data)
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
//    try! photos.save()

struct ProjectView_Previews: PreviewProvider{
    static var previews: some View {
        let project = try! Project(name: "Project 1")
        return ProjectView(name: project.name, photos: project.photos)
    }
}
