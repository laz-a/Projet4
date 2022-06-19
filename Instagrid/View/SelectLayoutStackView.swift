//
//  SelectLayoutStackView.swift
//  Instagrid
//
//  Created by laz on 08/06/2022.
//

import UIKit

final class SelectLayoutStackView: UIStackView {

    @IBOutlet private var selectLayoutViews: [SelectLayoutView]!
    
    var layout: Layout = .layout2 {
        didSet {
            setLayout()
        }
    }
    
    private func setLayout() {
        for selectLayoutView in selectLayoutViews {
            selectLayoutView.selected = layout.rawValue == selectLayoutView.tag
        }
    }
}
