//
//  MainCardCollectionViewCell.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/13.
//

import UIKit

final class MainCardCollectionViewCell: UICollectionViewCell {

    static let identifier = "MainCardCollectionViewCell"

    private let titleLabel = UILabel().then {
        $0.text = "오늘 얼마 아낀거지?"
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
    }

    private let cardImageView = UIImageView().then {
        $0.backgroundColor = UIColor(red: 1, green: 0.63, blue: 0.63, alpha: 1)
    }

    private let registerButton = UIButton().then {
        $0.setTitle("아낀 내역 추가하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setContentView()
        configureSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cardImageView.image = nil
    }

    private func setContentView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.07
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentView.layer.shadowRadius = 8
    }

    private func configureSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(cardImageView)
        contentView.addSubview(registerButton)
    }

    private func makeConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }

        cardImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(60)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(106)
        }

        registerButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
        }
    }
}
