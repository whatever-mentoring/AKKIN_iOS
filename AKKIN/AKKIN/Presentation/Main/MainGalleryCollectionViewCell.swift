//
//  MainGalleryCollectionViewCell.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/12/21.
//

import UIKit

final class MainGalleryCollectionViewCell: UICollectionViewCell {

    static let identifier = "MainGalleryCollectionViewCell"

    // MARK: UI Components
    private(set) var cardImageView = UIImageView()

    private(set) var saveContentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
    }

    private(set) var howLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
    }

    // MARK: init
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

    // MARK: SetContentView
    private func setContentView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.07
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentView.layer.shadowRadius = 8
    }

    // MARK: Configuration
    private func configureSubviews() {
        contentView.addSubview(cardImageView)
        contentView.addSubview(saveContentLabel)
        contentView.addSubview(howLabel)
    }

    // MARK: Layout
    private func makeConstraints() {
        cardImageView.snp.makeConstraints {
            $0.top.equalTo(contentView)
            $0.centerX.equalTo(contentView)
            $0.width.height.equalTo(163)
        }

        saveContentLabel.snp.makeConstraints {
            $0.top.equalTo(cardImageView.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(contentView).inset(8)
        }

        howLabel.snp.makeConstraints {
            $0.top.equalTo(saveContentLabel.snp.bottom).offset(2)
            $0.leading.trailing.equalTo(contentView).inset(8)
        }
    }
}
