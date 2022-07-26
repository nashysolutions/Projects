//
//  PhotoResolver.swift
//  Projects
//
//  Created by Robert Nash on 26/07/2022.
//

import UIKit
import Directory
import AsyncView

final class PhotoResolver<Item: DiskItem>: ObservableObject {
    
    enum Error: Swift.Error {
        case missing
    }
    
    typealias PhotoItem = Photo<Item>
    
    @Published var result: AsyncResult<UIImage> = .empty
    
    private let photo: PhotoItem
    
    init(photo: PhotoItem) {
        self.photo = photo
    }
    
    @MainActor
    func reload() async {
        
        result = .inProgress
        
        do {
            switch try photo.read() {
            case .none:
                result = .failure(Error.missing)
            case .some(let image):
                result = .success(image)
            }
        } catch {
            // the file may be missing, especially if you are using tmp dir in swiftui previews
            // or the decoder might fail because the data no longer corresponds with your value type, especially
            // if you are actively developing your model
            // so you may want to respond with delete action at call site
            result = .failure(error)
        }
        
//            Also available
//            let url = try photo.file().url
//            AsyncImage(url: )
//            However the above read() function caches for 1 minute, so
//            you will need to handle a cache yourself if you use url.
    }
}
