//
//  SelectLayoutView.swift
//  Instagrid
//
//  Created by laz on 01/06/2022.
//

import UIKit

final class SelectLayoutView: UIView {

    //Selected image outlet
    @IBOutlet weak var selectedImageView: UIImageView!
    
    //Selected property
    var selected: Bool = false {
        didSet {
            setSelected(selected)
        }
    }
    
    //Display/Hide selected image on layout button
    private func setSelected(_ selected: Bool) {
        selectedImageView.isHidden = !selected
    }

}
