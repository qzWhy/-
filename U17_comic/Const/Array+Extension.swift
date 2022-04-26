//
//  Array+Extension.swift
//  Owner
//
//  Created by 中时通 on 2022/2/14.
//  Copyright © 2022 轻舟. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    mutating func remove(_ object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}


