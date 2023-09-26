//
//  InputIconSelectedView.swift
//  AKKIN
//
//  Created by SJW on 2023/09/14.
//

import UIKit

enum Icon: CaseIterable {
    case iconThemeProfile1, iconThemeProfile2, iconThemeProfile3, iconThemeProfile4, iconThemeProfile5
    
    var image: UIImage {
        switch self {
        case .iconThemeProfile1: return AkkinImage.akkinIcon1
        case .iconThemeProfile2: return AkkinImage.akkinIcon2
        case .iconThemeProfile3: return AkkinImage.akkinIcon3
        case .iconThemeProfile4: return AkkinImage.akkinIcon4 
        case .iconThemeProfile5: return AkkinImage.akkinIcon5 
        }
    }
}

final class InputIconSelectedView: BaseView {

    // MARK: UI Components
    var onIconTapped: ((Icon) -> Void)?
    
    var buttons: [IconButton] = []
    
    private let iconStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureSubviews()
        makeConstraints()
        iconButtonSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        addSubview(iconStackView)
    }
    
    // MARK: Properties
    func iconButtonSetup() {
        self.buttons = Icon.allCases.map { icon in
            let button = IconButton(icon: icon)
            button.layer.cornerRadius = 8
            button.setImage(icon.image, for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
            button.backgroundColor = .akkinWhite
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.akkinGray3.cgColor
            button.snp.makeConstraints {
                $0.width.equalTo(44)
                $0.height.equalTo(44)
            }
            return button
        }
        
        for button in buttons {
            iconStackView.addArrangedSubview(button)
            button.addAction(UIAction(handler: { [weak self] _ in
                guard let self = self else { return }
                self.onIconTapped?(button.icon)
                self.setHighlightedState(button.icon)
            }), for: .touchUpInside)
        }
    }
    
    func setHighlightedState(_ icon: Icon) {
        for button in buttons {
            if button.icon == icon {
                button.layer.borderWidth = 1
                button.layer.borderColor = UIColor.akkinGreen.cgColor
            }
            else {
                button.layer.borderWidth = 2
                button.layer.borderColor = UIColor.akkinGray3.cgColor}
        }
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        iconStackView.snp.makeConstraints {
            $0.top
                .equalToSuperview()
            $0.width
                .equalTo(252)
            $0.centerX
                .equalToSuperview()
        }
    }
}
