//
//  CardDetailView.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/26.
//

import UIKit

final class CardDetailView: BaseView {

    // MARK: UI Components
    private let cardImageView = UIView().then {
        $0.backgroundColor = .akkinWhite
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.07
        $0.layer.shadowRadius = 8
        $0.layer.shadowOffset = .zero
    }
    
    private let dateTextLabel = UILabel().then {
        $0.text = "2023.09.26"
        $0.textColor = .akkinBlack
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private let iconImageView = UIImageView().then {
//        $0.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        $0.layer.cornerRadius = 8
        $0.image = AkkinImage.akkinIcon1
    }
    
    private let savePriceLabel = UILabel().then {
        $0.text = "무려 9,000원"
        $0.textColor = .akkinGreen
        $0.font = .systemFont(ofSize: 28, weight: .semibold)
        $0.textAlignment = .center
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "[ 헝그리 정신 실천 ]"
        $0.textColor = .akkinBlack
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 20, weight: .regular)
    }

    private let contentLabel = UILabel().then {
        $0.text = "밥 대신 공기 먹기"
        $0.textColor = .akkinBlack
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 20, weight: .regular)
    }

    private let expectCostLabel = UILabel().then {
        $0.text = "예상 비용"
        $0.textColor = .akkinBlack
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }

    private let expectPriceLabel = UILabel().then {
        $0.text = "10,000"
        $0.textColor = .akkinGreen
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }

    private let realCostLabel = UILabel().then {
        $0.text = "실제 비용"
        $0.textColor = .akkinBlack
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }

    private let realPriceLabel = UILabel().then {
        $0.text = "1,000"
        $0.textColor = .akkinGreen
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }

    private let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }

    private let diningButton = BaseButton().then {
        $0.setTitle("식비", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.layer.cornerRadius = 17
        $0.backgroundColor = .akkinGreen
//        $0.layer.borderWidth = 0.5
//        $0.layer.borderColor = UIColor.akkinGray3.cgColor
        $0.snp.makeConstraints {
            $0.width.equalTo(48)
            $0.height.equalTo(33)
        }
    }

    private let trafficButton = BaseButton().then {
        $0.setTitle("교통", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.layer.cornerRadius = 17
        $0.backgroundColor = .akkinWhite
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.akkinGray3.cgColor
        $0.snp.makeConstraints {
            $0.width.equalTo(48)
            $0.height.equalTo(33)
        }
    }

    private let shoppingButton = BaseButton().then {
        $0.setTitle("쇼핑", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.layer.cornerRadius = 17
        $0.backgroundColor = .akkinWhite
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.akkinGray3.cgColor
        $0.snp.makeConstraints {
            $0.width.equalTo(48)
            $0.height.equalTo(33)
        }
    }

    private let etcButton = BaseButton().then {
        $0.setTitle("기타", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.layer.cornerRadius = 17
        $0.backgroundColor = .akkinWhite
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.akkinGray3.cgColor
        $0.snp.makeConstraints {
            $0.width.equalTo(48)
            $0.height.equalTo(33)
        }
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        
        addSubview(cardImageView)

        cardImageView.addSubview(dateTextLabel)
        cardImageView.addSubview(iconImageView)
        cardImageView.addSubview(savePriceLabel)
        cardImageView.addSubview(titleLabel)
        cardImageView.addSubview(contentLabel)

        cardImageView.addSubview(expectCostLabel)
        cardImageView.addSubview(expectPriceLabel)
        cardImageView.addSubview(realCostLabel)
        cardImageView.addSubview(realPriceLabel)

        cardImageView.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(diningButton)
        buttonStackView.addArrangedSubview(trafficButton)
        buttonStackView.addArrangedSubview(shoppingButton)
        buttonStackView.addArrangedSubview(etcButton)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        cardImageView.snp.makeConstraints {
            $0.width.equalTo(314)
            $0.height.equalTo(544)
            $0.centerX.equalToSuperview()
        }

        dateTextLabel.snp.makeConstraints {
            $0.top.equalTo(cardImageView).inset(32)
            $0.centerX.equalTo(cardImageView.snp.centerX)
        }

        iconImageView.snp.makeConstraints {
            $0.top.equalTo(cardImageView).inset(80)
            $0.centerX.equalTo(cardImageView.snp.centerX)
            $0.width.height.equalTo(172)
        }

        savePriceLabel.snp.makeConstraints {
            $0.top.equalTo(cardImageView).inset(276)
            $0.centerX.equalTo(cardImageView.snp.centerX)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(cardImageView).inset(328)
            $0.centerX.equalTo(cardImageView.snp.centerX)
        }

        contentLabel.snp.makeConstraints {
            $0.top.equalTo(cardImageView).inset(358)
            $0.centerX.equalTo(cardImageView.snp.centerX)
        }

        expectCostLabel.snp.makeConstraints {
            $0.top.equalTo(cardImageView).inset(408)
            $0.leading.equalTo(cardImageView).inset(60)
        }

        expectPriceLabel.snp.makeConstraints {
            $0.top.equalTo(cardImageView).inset(437)
            $0.centerX.equalTo(expectCostLabel)
        }

        realCostLabel.snp.makeConstraints {
            $0.top.equalTo(cardImageView).inset(408)
            $0.trailing.equalTo(cardImageView).inset(60)
        }

        realPriceLabel.snp.makeConstraints {
            $0.top.equalTo(cardImageView).inset(437)
            $0.centerX.equalTo(realCostLabel)
        }

        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(cardImageView).inset(479)
            $0.centerX.equalTo(cardImageView)
        }
    }
}
