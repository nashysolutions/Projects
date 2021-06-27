//
//  FolderStorage.swift
//  Trader
//
//  Created by Robert Nash on 21/06/2021.
//

import Foundation
import Files

struct FolderStorage {
    
    static func loadRootFolder() throws -> Folder {
        let folder = try applicationSupportDirectory()
        return try folder.createSubfolderIfNeeded(withName: "Data")
    }
    
    private static func applicationSupportDirectory() throws -> Folder {
        let url = try FileManager.default.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        return try Folder(path: url.path)
    }
}
