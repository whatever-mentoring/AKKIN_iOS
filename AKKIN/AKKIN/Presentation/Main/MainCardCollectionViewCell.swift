//
//  MainCardCollectionViewCell.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/13.
//

import UIKit

final class MainCardCollectionViewCell: UICollectionViewCell {

    static let identifier = "MainCardCollectionViewCell"

    // MARK: UI Components
    private(set) var cardImageView = UIImageView()

    private(set) var moneyLabel = UILabel().then {
        $0.textColor = .akkinGreen
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
    }

    private(set) var saveContentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
    }

    private(set) var howLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
    }

    private(set) var emptyLabel = UILabel().then {
        $0.text = AkkinString.emptyAkkin
        $0.textColor = .akkinGray4
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 16)
        $0.isHidden = true
    }

    // MARK: SetLineSpacing
    private func setLineSpacing() {
        let attrString = NSMutableAttributedString(string: emptyLabel.text ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        emptyLabel.attributedText = attrString
    }

    // MARK: init
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

    // MARK: SetContentView
    private func setContentView() {
        contentView.backgroundColor = .akkinWhite
        contentView.layer.cornerRadius = 16
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.07
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentView.layer.shadowRadius = 8
    }

    // MARK: Configuration
    private func configureSubviews() {
        contentView.addSubview(cardImageView)
        contentView.addSubview(moneyLabel)
        contentView.addSubview(saveContentLabel)
        contentView.addSubview(howLabel)
        contentView.addSubview(emptyLabel)
    }

    // MARK: Layout
    private func makeConstraints() {
        cardImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(43)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(104)
        }

        moneyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(172)
            $0.centerX.equalToSuperview()
        }

        saveContentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(202)
            $0.centerX.equalToSuperview()
        }

        howLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(227)
            $0.centerX.equalToSuperview()
        }

        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
