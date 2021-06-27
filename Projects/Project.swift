//
//  Project.swift
//  Trader
//
//  Created by Robert Nash on 12/06/2021.
//

import UIKit
import Files
import Directory

struct Project: Identifiable, Container {
    
    let id: UUID
    let name: String
    let parent: Folder
    
    var folderName: String {
        "Project_" + name.alphanumericsOnly
    }
}

private struct Storage {
        
    static func loadProjectFolder() throws -> Folder {
        let folder = try FolderStorage.loadRootFolder()
        return try folder.createSubfolderIfNeeded(withName: "Projects")
    }
}

extension Directory where Item == Project {
    
    convenience init(isPreview: Bool = false) throws {
        let folder = try Storage.loadProjectFolder()
        try self.init(parent: folder, fileName: "projects.json", isPreview: isPreview)
    }
}

extension Project: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id, name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(UUID.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        try self.init(id: id, name: name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
}

extension Project {
    
    init(id: UUID = .init(), name: String) throws {
        let folder = try Storage.loadProjectFolder()
        self.init(id: id, name: name, parent: folder)
    }
}

extension Project: Equatable {
    
    static func == (lhs: Project, rhs: Project) -> Bool {
        lhs.name == rhs.name
    }
}

extension Project: PhotoStore {
    
    var photos: PhotosDirectory<Project> {
        try! PhotosDirectory<Project>(item: self)
    }
}
