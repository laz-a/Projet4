//
//  Grid.swift
//  Instagrid
//
//  Created by laz on 10/06/2022.
//

import Foundation
import UIKit


final class Grid {
    var layout: Layout = .layout2
    var images: [UIImage?] = [nil, nil , nil, nil]
    
    var isComplete: Bool {
        return isGridComplete()
    }
    
    private func isGridComplete() -> Bool {
        for (index, image) in images.enumerated() {
            if image == nil && !(layout == .layout1 && index == 1) && !(layout == .layout2 && index == 3) {
                return false
            }
        }
        return true
    }
}
