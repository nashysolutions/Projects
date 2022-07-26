//
//  PhotoView.swift
//  Projects
//
//  Created by Robert Nash on 26/07/2022.
//

import SwiftUI
import Directory

struct PhotoView<Item: DiskItem>: View {
    
    @StateObject var resolver: PhotoResolver<Item>
    
    init(photo: Photo<Item>) {
        _resolver = StateObject(wrappedValue: PhotoResolver(photo: photo))
    }
    
    var body: some View {
        view(for: resolver.result)
            .task {
                await resolver.reload()
            }
    }
    
    @ViewBuilder
    private func view(for result: AsyncResult<UIImage>) -> some View {
        switch resolver.result {
        case .inProgress:
            ProgressView()
        case .empty:
            Color.clear
        case .failure(let error):
            Text(error.localizedDescription)
        case .success(let image):
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}
