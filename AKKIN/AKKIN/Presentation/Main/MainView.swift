//
//  MainView.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/13.
//

import UIKit

final class MainView: BaseView {
    
    // MARK: UI Components
    
    // MARK: Properties
    var tapAdd: (() -> Void)?
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
    }
    
    // MARK: Event
    @objc private func handleAddEvent() {
        tapAdd?()
    }
}
