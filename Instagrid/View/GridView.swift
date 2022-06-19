//
//  GridView.swift
//  Instagrid
//
//  Created by laz on 07/06/2022.
//

import UIKit

final class GridView: UIView {
    @IBOutlet private var imagePickerViews: [ImagePickerView]!
    
    //Set layout
    var layout: Layout = .layout2 {
        didSet {
            setLayout()
        }
    }
    
    //Return image created
    var image: UIImage {
        return gridToImage()
    }
    
    //Set layout
    private func setLayout() {
        //Display/hide imagePickerViews relative to selected layout
        for imagePickerView in imagePickerViews {
            imagePickerView.isHidden = (layout == .layout1 && imagePickerView.tag == 1)
                                        || (layout == .layout2 && imagePickerView.tag == 3)
        }
    }
    
    //Display selected image in selected position
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
