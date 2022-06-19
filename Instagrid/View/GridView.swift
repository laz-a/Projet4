//
//  GridView.swift
//  Instagrid
//
//  Created by laz on 07/06/2022.
//

import UIKit

final class GridView: UIView {
    @IBOutlet private var imagePickerViews: [ImagePickerView]!
    
    var layout: Layout = .layout2 {
        didSet {
            setLayout()
        }
    }
    
    var image: UIImage {
        return gridToImage()
    }
    
    private func setLayout() {
        for imagePickerView in imagePickerViews {
            imagePickerView.isHidden = (layout == .layout1 && imagePickerView.tag == 1)
                                        || (layout == .layout2 && imagePickerView.tag == 3)
        }
    }
    
    func setImage(tag: Int, image: UIImage) {
        if let imagePickerView = imagePickerViews.first(where: { $0.tag == tag }) {
            imagePickerView.image = image
        }
    }
    
    //Create screenshot of grid view
    private func gridToImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        return renderer.image { context in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
    }
}
