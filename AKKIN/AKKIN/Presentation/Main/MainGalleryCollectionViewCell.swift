//
//  MainGalleryCollectionViewCell.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/12/21.
//

import UIKit

final class MainGalleryCollectionViewCell: UICollectionViewCell {

    static let identifier = "MainGalleryCollectionViewCell"

    private(set) var cardImageView = UIImageView()

    private(set) var saveContentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
    }

    private(set) var howLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
    }

    private(set) var emptyLabel = UILabel().then {
        $0.text = AkkinString.emptyAkkin
        $0.textColor = UIColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 1)
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 16)
        $0.isHidden = true
    }

    private func setLineSpacing() {
        let attrString = NSMutableAttributedString(string: emptyLabel.text ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        emptyLabel.attributedText = attrString
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setContentView()
        configureSubviews()
        makeConstraints()
        setLineSpacing()
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
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.07
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentView.layer.shadowRadius = 8
    }

    private func configureSubviews() {
        contentView.addSubview(cardImageView)
        contentView.addSubview(saveContentLabel)
        contentView.addSubview(howLabel)
        contentView.addSubview(emptyLabel)
    }

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

        emptyLabel.snp.makeConstraints {
            $0.center.equalTo(contentView)
        }
    }
}
