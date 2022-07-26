//
//  RootDir.swift
//  Projects
//
//  Created by Robert Nash on 26/07/2022.
//

import Foundation
import Files

enum RootDir {
    
    case temp
    case support
    
    var folder: Folder {
        try! location.createSubfolderIfNeeded(withName: "Data")
    }
    
    private var location: Folder {
        switch self {
        case .temp:
            return Folder.temporary
        case .support:
            return Folder.applicationSupportDirectory
        }
    }
}

private extension Folder {
    
    static var applicationSupportDirectory: Folder {
        let url = try! FileManager.default.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        return try! Folder(path: url.path)
    }
}
