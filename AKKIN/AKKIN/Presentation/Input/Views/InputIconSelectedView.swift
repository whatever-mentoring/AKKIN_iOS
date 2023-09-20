//
//  InputIconSelectedView.swift
//  AKKIN
//
//  Created by SJW on 2023/09/14.
//

import UIKit

final class IconButton: UIButton {
    var tap: ((IconButton) -> Void)?
    
    let icon: Icon
    init(icon: Icon) {
        self.icon = icon
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum Icon: CaseIterable {
    case iconThemeProfile1, iconThemeProfile2, iconThemeProfile3, iconThemeProfile4, iconThemeProfile5
    
    var title: String {
        switch self {
        case .iconThemeProfile1: return "1"
        case .iconThemeProfile2: return "2"
        case .iconThemeProfile3: return "3"
        case .iconThemeProfile4: return "4"
        case .iconThemeProfile5: return "5"
        }
    }
    
    var image: UIImage {
        switch self {
        case .iconThemeProfile1: return UIImage()
        case .iconThemeProfile2: return UIImage()
        case .iconThemeProfile3: return UIImage()
        case .iconThemeProfile4: return UIImage()
        case .iconThemeProfile5: return UIImage()
        }
    }
}

final class InputIconSelectedView: BaseView{

    // MARK: UI Components
    private let iconStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    var iconButtons = [IconButton]()
    
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
        let items = Icon.allCases.map { icon in
            let button = IconButton(icon: icon)
            button.layer.cornerRadius = 8
            button.setTitle(icon.title, for: .normal)
            button.setImage(icon.image, for: .normal)
            button.backgroundColor = .akkinWhite
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.akkinGray.cgColor
            button.snp.makeConstraints {
                $0.width.equalTo(44)
                $0.height.equalTo(44)
            }
            return button
        }
    
        for button in items {
            iconStackView.addArrangedSubview(button)
            button.tap = { [weak self] iconType in
                guard let self else { return }
                tapIcon(iconType.icon)
            }
        }
    }
    
    func tapIcon(_ icon: Icon) {
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
