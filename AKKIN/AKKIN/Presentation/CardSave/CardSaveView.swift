//
//  CardSaveView.swift
//  AKKIN
//
//  Created by SJW on 2023/09/16.
//

import UIKit

final class CardSaveView: BaseView {

    // MARK: UI Components
    private let cardImageView = UIView().then {
        $0.backgroundColor = .akkinWhite
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor.akkinGray1.cgColor
        $0.layer.shadowOpacity = 1
        $0.layer.shadowRadius = 8
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
    }

    private let cardStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
        $0.alignment = .center
    }

    private let dateTextLabel = UILabel().then {
        $0.textColor = .akkinBlack
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }

    private let iconImageView = UIImageView().then {
        $0.backgroundColor = .akkinBG
    }

    private let saveTextLabel = UILabel().then {
        $0.textColor = .akkinGreen
        $0.font = .systemFont(ofSize: 28, weight: .semibold)
    }

    private let scriptTextLabel = UILabel().then {
        $0.textColor = .akkinBlack
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 20, weight: .regular)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(cardImageView)
        cardImageView.addSubview(cardStackView)
        cardStackView.addArrangedSubview(dateTextLabel)
        cardStackView.addArrangedSubview(iconImageView)
        cardStackView.addArrangedSubview(saveTextLabel)
        cardStackView.addArrangedSubview(scriptTextLabel)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        cardImageView.snp.makeConstraints {
            $0.width.equalTo(293)
            $0.height.equalTo(403)
            $0.centerX.equalToSuperview()
        }

        cardStackView.snp.makeConstraints {
            $0.top.equalTo(cardImageView.snp.top).offset(30)
            $0.centerX.equalToSuperview()
        }

        iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(172)
        }
    }

    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }

    func configure(
        selectedYear: Int?,
        selectedMonth: Int?,
        selectedDay: Int?,
        selectedImage: UIImage?,
        selectedSaveContent: String?,
        selectedHow: String?,
        selectedExpectCost: Int?,
        selectedRealCost: Int?
    ) {
        if let year = selectedYear,
            let month = selectedMonth,
            let day = selectedDay,
            let image = selectedImage,
            let saveContent = selectedSaveContent,
            let how = selectedHow,
            let expectCost = selectedExpectCost,
            let realCost = selectedRealCost
        {
            dateTextLabel.text = "\(year) / \(month) / \(day)"
            saveTextLabel.text = (expectCost - realCost).toPriceFormat.toMoney
            scriptTextLabel.text = "\(saveContent.toSaveContent)\n\(how)"
            iconImageView.image = image
        }
    }
}
