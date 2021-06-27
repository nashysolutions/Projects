//
//  String+extensions.swift
//  Trader
//
//  Created by Robert Nash on 21/06/2021.
//

import Foundation

extension StringProtocol {
    
    var alphanumericsOnly: String {
        components(separatedBy: CharacterSet.alphanumerics.inverted).joined(separator: "")
    }
}
