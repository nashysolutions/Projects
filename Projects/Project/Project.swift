//
//  Project.swift
//  Trader
//
//  Created by Robert Nash on 12/06/2021.
//

import UIKit
import Files
import Directory

struct Project: DirectoryItem {
    
    var id: Self { self }
    
    let name: String
    let person: Person

    var parent: Folder {
        person.projectsFolder()
    }
    
    var folderName: String {
        "Project_" + name.alphanumericsOnly
    }
    
    static func == (lhs: Project, rhs: Project) -> Bool {
        lhs.name == rhs.name
    }
}

private let databaseFilename = "projects.json"

extension Directory where Item == Project {
    
    convenience init(container person: Person) {
        try! self.init(
            parent: person.projectsFolder(),
            fileName: databaseFilename
        )
    }
}

private extension Person {
    
    func projectsFolder() -> Folder {
        try! folder.createSubfolderIfNeeded(withName: "Projects")
    }
}
