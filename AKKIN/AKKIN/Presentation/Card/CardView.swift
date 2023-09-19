//
//  CardView.swift
//  AKKIN
//
//  Created by SJW on 2023/09/16.
//

import UIKit

final class CardView: BaseView {
    
    var saveCost: Int = 100
    
    // MARK: UI Components
    
    private let CardImageView = UIView().then {
        $0.backgroundColor = .akkinWhite
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor.akkinShadow.cgColor
        $0.layer.shadowOpacity = 1
        $0.layer.shadowRadius = 8
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    private let CardStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    
    private let dateTextLabel = UILabel().then {
        $0.text = "YYYY / MM / DD"
        $0.textColor = .akkinBlack
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    private let iconImageView = UIImageView().then {
        $0.backgroundColor = .akkinGray
    }
    
    private let saveTextLabel = UILabel().then {
        $0.text = "무려 000원"
        $0.textColor = .akkinGreen
        $0.font = .systemFont(ofSize: 28, weight: .semibold)
    }
    
    private let scriptTextLabel = UILabel().then {
        $0.text = "[헝그리 정신 실천]\n밥 대신 공기 먹기"
        $0.textColor = .akkinBlack
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 20, weight: .regular)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        
        addSubview(CardImageView)
        CardImageView.addSubview(CardStackView)
        CardStackView.addArrangedSubview(dateTextLabel)
        CardStackView.addArrangedSubview(iconImageView)
        CardStackView.addArrangedSubview(saveTextLabel)
        CardStackView.addArrangedSubview(scriptTextLabel)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        CardImageView.snp.makeConstraints {
            $0.width.equalTo(293)
            $0.height.equalTo(403)
            $0.centerX.equalToSuperview()
        }
        CardStackView.snp.makeConstraints {
            $0.top.equalTo(CardImageView.snp.top).offset(30)
            $0.centerX.equalToSuperview()
        }
        iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(172)
        }
    }
}
