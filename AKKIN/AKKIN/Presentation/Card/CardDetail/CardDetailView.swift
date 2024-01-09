//
//  CardDetailView.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/26.
//

import UIKit

final class CardDetailView: BaseView {

    // MARK: UI Components
    public var cardImageView = UIView().then {
        $0.backgroundColor = .akkinWhite
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.07
        $0.layer.shadowRadius = 8
        $0.layer.shadowOffset = .zero
    }

    public var dateTextLabel = UILabel().then {
        $0.textColor = .akkinBlack
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }

    public var iconImageView = UIImageView().then {
        $0.layer.cornerRadius = 8
        $0.image = AkkinImage.akkinIcon1
    }

    public var savePriceLabel = UILabel().then {
        $0.textColor = .akkinGreen
        $0.font = .systemFont(ofSize: 28, weight: .semibold)
        $0.textAlignment = .center
    }

    public var saveContentLabel = UILabel().then {
        $0.textColor = .akkinBlack
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 20, weight: .regular)
    }

    public var howLabel = UILabel().then {
        $0.textColor = .akkinBlack
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 20, weight: .regular)
    }

    private let expectTextLabel = UILabel().then {
        $0.text = AkkinString.expect
        $0.textColor = .akkinBlack
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }

    public var expectPriceLabel = UILabel().then {
        $0.textColor = .akkinGreen
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }

    private let realTextLabel = UILabel().then {
        $0.text = AkkinString.real
        $0.textColor = .akkinBlack
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }

    public var realPriceLabel = UILabel().then {
        $0.textColor = .akkinGreen
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }

    private let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }

    public var diningButton = BaseButton().then {
        $0.setTitle(AkkinString.dining, for: .normal)
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

    public var trafficButton = BaseButton().then {
        $0.setTitle(AkkinString.traffic, for: .normal)
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

    public var shoppingButton = BaseButton().then {
        $0.setTitle(AkkinString.shopping, for: .normal)
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

    public var etcButton = BaseButton().then {
        $0.setTitle(AkkinString.etc, for: .normal)
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
        cardImageView.addSubview(saveContentLabel)
        cardImageView.addSubview(howLabel)

        cardImageView.addSubview(expectTextLabel)
        cardImageView.addSubview(expectPriceLabel)
        cardImageView.addSubview(realTextLabel)
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

        saveContentLabel.snp.makeConstraints {
            $0.top.equalTo(cardImageView).inset(328)
            $0.centerX.equalTo(cardImageView.snp.centerX)
        }

        howLabel.snp.makeConstraints {
            $0.top.equalTo(cardImageView).inset(358)
            $0.centerX.equalTo(cardImageView.snp.centerX)
        }

        expectTextLabel.snp.makeConstraints {
            $0.top.equalTo(cardImageView).inset(408)
            $0.leading.equalTo(cardImageView).inset(60)
        }

        expectPriceLabel.snp.makeConstraints {
            $0.top.equalTo(cardImageView).inset(437)
            $0.centerX.equalTo(expectTextLabel)
        }

        realTextLabel.snp.makeConstraints {
            $0.top.equalTo(cardImageView).inset(408)
            $0.trailing.equalTo(cardImageView).inset(60)
        }

        realPriceLabel.snp.makeConstraints {
            $0.top.equalTo(cardImageView).inset(437)
            $0.centerX.equalTo(realTextLabel)
        }

        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(cardImageView).inset(479)
            $0.centerX.equalTo(cardImageView)
        }
    }
}
