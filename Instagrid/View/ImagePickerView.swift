//
//  ImagePickerView.swift
//  Instagrid
//
//  Created by laz on 01/06/2022.
//

import UIKit

final class ImagePickerView: UIView {

    //Image view outlet
    @IBOutlet weak var imageView: UIImageView!
    
    //Set image og image view
    var image: UIImage? {
        didSet{
            imageView.image = image
        }
    }

}
