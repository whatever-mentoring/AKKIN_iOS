//
//  ExampleCustomView.swift
//  AKKIN
//
//  Created by MK-Mac-413 on 2023/09/04.
//

import UIKit

final class ExampleCustomView: BaseView {
    
    // MARK: UI Components
    private let addButton = BaseButton()
    
    // MARK: Properties
    var tapAdd: (() -> Void)?
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        
        addSubview(addButton)
        addButton.addTarget(self, action: #selector(handleAddEvent), for: .touchUpInside)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        addButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: Event
    @objc private func handleAddEvent() {
        tapAdd?()
    }
}
