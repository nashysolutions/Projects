//
//  AsyncResult.swift
//  Projects
//
//  Created by Robert Nash on 26/07/2022.
//

import Foundation

enum AsyncResult<Success> {
    case empty
    case inProgress
    case success(Success)
    case failure(Error)
}
