//
//  InputIconSelectedView.swift
//  AKKIN
//
//  Created by SJW on 2023/09/14.
//

import UIKit

enum Icon: CaseIterable {
    case iconThemeProfile1
    case iconThemeProfile2
    case iconThemeProfile3
    case iconThemeProfile4
    case iconThemeProfile5
    
    var image: UIImage {
        switch self {
        case .iconThemeProfile1: return AkkinImage.akkinIcon1
        case .iconThemeProfile2: return AkkinImage.akkinIcon2
        case .iconThemeProfile3: return AkkinImage.akkinIcon3
        case .iconThemeProfile4: return AkkinImage.akkinIcon4 
        case .iconThemeProfile5: return AkkinImage.akkinIcon5 
        }
    }

    var imageString: String {
        switch self {
        case .iconThemeProfile1: return "icon_1"
        case .iconThemeProfile2: return "icon_2"
        case .iconThemeProfile3: return "icon_3"
        case .iconThemeProfile4: return "icon_4"
        case .iconThemeProfile5: return "icon_5"
        }
    }
}

final class InputIconSelectedView: BaseView {

    // MARK: UI Components
    var onIconTapped: ((Icon) -> Void)?
    public var selectedIcon: String?

    var buttons: [IconButton] = []

    private let iconStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }

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
                print(onIconTapped ?? "nil")
                self.setHighlightedState(button.icon)
            }), for: .touchUpInside)
        }
    }

    public func setHighlightedState(_ icon: Icon) {
        for button in buttons {
            if button.icon == icon {
                print("imageString: " + "\(icon.imageString)")
                selectedIcon = "\(icon.imageString)"
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
            $0.top.equalToSuperview()
            $0.width.equalTo(252)
            $0.centerX.equalToSuperview()
        }
    }
}
