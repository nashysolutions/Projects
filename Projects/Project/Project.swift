//
//  Project.swift
//  Trader
//
//  Created by Robert Nash on 12/06/2021.
//

import UIKit
import Files
import Directory

private let databaseFilename = "projects.json"

private func projectsFolder() -> Folder {
    let folder = FolderStorage.loadRootFolder()
    return try! folder.createSubfolderIfNeeded(withName: "Projects")
}

struct Project: Hashable, Identifiable, Container, Codable {
    
    var id: Self { self }
    
    let name: String

    var parent: Folder {
        projectsFolder()
    }
    
    var folderName: String {
        "Project_" + name.alphanumericsOnly
    }
    
    static func == (lhs: Project, rhs: Project) -> Bool {
        lhs.name == rhs.name
    }
}

extension Directory where Item == Project {
    
    convenience init(isPreview: Bool = false) throws {
        try self.init(
            parent: projectsFolder(),
            fileName: databaseFilename,
            isPreview: isPreview
        )
    }
}
