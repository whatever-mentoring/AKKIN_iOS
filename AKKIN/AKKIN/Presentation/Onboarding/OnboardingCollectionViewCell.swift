//
//  OnboardingCollectionViewCell.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/20.
//

import UIKit

final class OnboardingCollectionViewCell: UICollectionViewCell {

    static let identifier = "OnboardingCollectionViewCell"

    // MARK: UI Components
    private(set) var onboardingImageView = UIImageView()

    private(set) var skipButton = BaseButton().then {
        $0.setImage(UIImage(named: "skipButton"), for: .normal)
    }

    private(set) var startButton = BaseButton().then {
        $0.setTitle("아낀거지 시작하기", for: .normal)
        $0.backgroundColor = .akkinGreen
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.layer.cornerRadius = 16
        $0.isHidden = true
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
    }

    private func setContentView() {
    }

    private func configureSubviews() {
        contentView.addSubview(onboardingImageView)
        contentView.addSubview(skipButton)
        contentView.addSubview(startButton)
    }

    private func makeConstraints() {
        onboardingImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(15)
        }

        skipButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(55)
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(30)
            $0.width.equalTo(51)
            $0.height.equalTo(21)
        }

        startButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(90)
            $0.height.equalTo(60)
        }
    }
}
