//
//  CategoryButton.swift
//  AKKIN
//
//  Created by SJW on 2023/09/23.
//

import UIKit

final class CategoryButton: UIButton {
    
    let category: Category
    
    init(category: Category) {
        self.category = category
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
