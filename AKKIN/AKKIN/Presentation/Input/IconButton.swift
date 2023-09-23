//
//  IconButton.swift
//  AKKIN
//
//  Created by SJW on 2023/09/22.
//

import UIKit

final class IconButton: UIButton {
    
    let icon: Icon
    
    init(icon: Icon) {
        self.icon = icon
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
