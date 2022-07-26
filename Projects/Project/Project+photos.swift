//
//  Project+photos.swift
//  Projects
//
//  Created by Robert Nash on 23/07/2022.
//

import Foundation
import Directory

extension Project: PhotoStore {
    
    var photos: PhotosDirectory<Project> {
        try! PhotosDirectory<Project>(for: self)
    }
}
