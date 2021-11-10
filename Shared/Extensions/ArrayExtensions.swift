//
//  ArrayExtensions.swift
//  ArrayExtensions
//
//  Created by Slava Nagornyak on 17.07.2021.
//

import Foundation

extension Array where Element == Item {
    func unique() -> Self {
        filter { item in
            !contains { $0.id == item.id }
        }
    }
    
    func sortedItems() -> Self {
        sorted { lhs, rhs in
            guard let lPart = (lhs as? Part),
                  let rPart = (rhs as? Part) else { return true }
                  
            return lPart.rawResource && rPart.rawResource
                ? rPart.isLiquid
                : rPart.rawResource
        }
    }
}
