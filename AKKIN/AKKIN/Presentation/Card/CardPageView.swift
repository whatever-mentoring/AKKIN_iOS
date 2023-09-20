//
//  CardPageView.swift
//  AKKIN
//
//  Created by SJW on 2023/09/17.
//

import UIKit

final class CardPageView: BaseView {
    
    // MARK: UI Components
    
    private let homeButton = UIButton().then {
        $0.setImage(UIImage(named: "homeButton"), for: .normal)
    }
    
    private let cardTopText = UILabel().then {
        $0.text = "오늘의 소비 카드가 \n완성됐어요."
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = .systemFont(ofSize: 24, weight: .semibold)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }
    
    private let cardView = CardView()
    
    let imageSaveButton = BaseButton().then {
        $0.setTitle("이미지 저장하기", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(red: 0.137, green: 0.678, blue: 0.373, alpha: 1)
        $0.layer.cornerRadius = 16
    }
    let imageShareButton = BaseButton().then {
        $0.setTitle("이미지 공유하기", for: .normal)
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
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        addSubview(homeButton)
        addSubview(cardTopText)
        addSubview(cardView)
        addSubview(imageSaveButton)
        addSubview(imageShareButton)
        
        homeButton.addTarget(self, action: #selector(handleAddEvent), for: .touchUpInside)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        homeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.leading.equalToSuperview().offset(18)
        }
        cardTopText.snp.makeConstraints {
            $0.top.equalTo(homeButton.snp.bottom).offset(33)
            $0.leading.equalToSuperview().offset(24)
        }
        cardView.snp.makeConstraints {
            $0.top.equalTo(cardTopText.snp.bottom).offset(49)
            $0.width.equalTo(293)
            $0.height.equalTo(403)
            $0.centerX.equalToSuperview()
        }
        imageSaveButton.snp.makeConstraints {
            $0.top.equalTo(cardView.snp.bottom).offset(50)
            $0.width.equalTo(342)
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview()
        }
        imageShareButton.snp.makeConstraints {
            $0.top.equalTo(imageSaveButton.snp.bottom).offset(12)
            $0.width.equalTo(342)
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: Event
    @objc private func handleAddEvent() {
        tap?()
    }
}
