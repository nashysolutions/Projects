//
//  Person.swift
//  Projects
//
//  Created by Robert Nash on 23/07/2022.
//

import Foundation
import Directory
import Files

struct Person: Hashable, Identifiable, SovereignContainer, Codable {
    
    static var root: RootDir = .support
    
    var id: Self { self }
    
    let name: String
    
    var folderName: String {
        "Person_" + name.alphanumericsOnly
    }
    
    var parent: Folder {
        personsFolder()
    }
    
    static func ==(lhs: Person, rhs: Person) -> Bool {
        lhs.name == rhs.name
    }
}

private let databaseFilename = "persons.json"

extension Directory where Item == Person {
    
    convenience init() throws {
        try self.init(
            parent: personsFolder(),
            fileName: databaseFilename
        )
    }
}

private func personsFolder() -> Folder {
    let root = Person.root.folder
    return try! root.createSubfolderIfNeeded(withName: "Persons")
}
