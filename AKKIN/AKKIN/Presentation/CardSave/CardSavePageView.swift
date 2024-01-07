//
//  CardPageView.swift
//  AKKIN
//
//  Created by SJW on 2023/09/17.
//

import UIKit

final class CardSavePageView: BaseView {

    var selectedYear: Int?
    var selectedMonth: Int?
    var selectedDay: Int?
    var selectedCategory: String?
    var selectedSaveContent: String?
    var selectedHow: String?
    var selectedExpectCost: Int?
    var selectedRealCost: Int?

    // MARK: UI Components
    private let homeButton = UIButton().then {
        $0.setImage(AkkinButton.homeButton, for: .normal)
    }
    
    private let cardTopText = UILabel().then {
        $0.text = AkkinString.completeAkkin
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = .systemFont(ofSize: 24, weight: .semibold)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }

    private let cardSaveView = CardSaveView()

    let imageSaveButton = BaseButton().then {
        $0.setTitle(AkkinString.saveImage, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(red: 0.137, green: 0.678, blue: 0.373, alpha: 1)
        $0.layer.cornerRadius = 16
    }

    let imageShareButton = BaseButton().then {
        $0.setTitle(AkkinString.shareImage, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.setTitleColor(UIColor(red: 0.137, green: 0.678, blue: 0.373, alpha: 1), for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor(red: 0.082, green: 0.082, blue: 0.082, alpha: 0.07).cgColor
        $0.layer.shadowOpacity = 1
        $0.layer.shadowRadius = 12
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
    }

    // MARK: Properties
    var tap: (() -> Void)?
    var tapImage: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        addSubview(homeButton)
        addSubview(cardTopText)
        addSubview(cardSaveView)
        addSubview(imageSaveButton)
        addSubview(imageShareButton)

        homeButton.addTarget(self, action: #selector(handleAddEvent), for: .touchUpInside)
        imageSaveButton.addTarget(self, action: #selector(handleTapEvent), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        homeButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(18)
        }

        cardTopText.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(40)
            $0.leading.equalToSuperview().offset(24)
        }

        cardSaveView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(135)
            $0.width.equalTo(293)
            $0.height.equalTo(403)
            $0.centerX.equalToSuperview()
        }

        imageSaveButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(584)
            $0.width.equalTo(342)
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview()
        }

        imageShareButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(656)
            $0.width.equalTo(342)
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview()
        }
    }

    // MARK: Event
    @objc private func handleAddEvent() {
        tap?()
    }

    @objc private func handleTapEvent() {
        tapImage?()
    }

    func saveCardViewAsImage() -> UIImage {
        return cardSaveView.asImage()
    }

    func configureCardSaveView(
        selectedYear: Int?,
        selectedMonth: Int?,
        selectedDay: Int?,
        selectedImage: UIImage?,
        selectedSaveContent: String?,
        selectedHow: String?,
        selectedExpectCost: Int?,
        selectedRealCost: Int?
    ) {
        cardSaveView.configure(
            selectedYear: selectedYear,
            selectedMonth: selectedMonth,
            selectedDay: selectedDay,
            selectedImage: selectedImage,
            selectedSaveContent: selectedSaveContent,
            selectedHow: selectedHow,
            selectedExpectCost: selectedExpectCost,
            selectedRealCost: selectedRealCost
        )
    }
}
