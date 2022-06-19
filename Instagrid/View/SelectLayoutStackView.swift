//
//  SelectLayoutStackView.swift
//  Instagrid
//
//  Created by laz on 08/06/2022.
//

import UIKit

final class SelectLayoutStackView: UIStackView {

    @IBOutlet private var selectLayoutViews: [SelectLayoutView]!
    
    //Set Layout
    var layout: Layout = .layout2 {
        didSet {
            setLayout()
        }
    }
    
    //Display/hide selected image in selectLayoutViews
    private func setLayout() {
        for selectLayoutView in selectLayoutViews {
            selectLayoutView.selected = layout.rawValue == selectLayoutView.tag
        }
    }
}
