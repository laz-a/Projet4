//
//  Grid.swift
//  Instagrid
//
//  Created by laz on 10/06/2022.
//

import Foundation
import UIKit


final class Grid {
    //Layout
    var layout: Layout = .layout2
    
    //Array of images in grid
    var images: [UIImage?] = [nil, nil , nil, nil]
    
    //Grid completed
    var isComplete: Bool {
        return isGridComplete()
    }
    
    //Verify if all image are present in the grid
    private func isGridComplete() -> Bool {
        for (index, image) in images.enumerated() {
            if image == nil && !(layout == .layout1 && index == 1) && !(layout == .layout2 && index == 3) {
                return false
            }
        }
        return true
    }
}
