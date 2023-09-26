//
//  MainCardCollectionViewCell.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/13.
//

import UIKit

final class MainCardCollectionViewCell: UICollectionViewCell {

    static let identifier = "MainCardCollectionViewCell"

    private(set) var cardImageView = UIImageView().then {
        $0.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
    }

    private(set) var moneyLabel = UILabel().then {
        $0.text = "무려 000,000 원"
        $0.textColor = UIColor(red: 0.14, green: 0.68, blue: 0.37, alpha: 1)
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
    }

    private(set) var cardLabel = UILabel().then {
        $0.text = "[ 헝그리 정신 실천 ]"
        $0.font = .systemFont(ofSize: 16)
    }

    private(set) var contentLabel = UILabel().then {
        $0.text = "밥 대신 공기 먹기"
        $0.font = .systemFont(ofSize: 16)
    }

    private(set) var emptyLabel = UILabel().then {
        $0.text = """
        만들어진 카드가 없어요.
        우측 상단의 + 버튼을 통해
        아낀 내역을 추가해보세요.
        """
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
        contentView.layer.cornerRadius = 16
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.07
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentView.layer.shadowRadius = 8
    }

    private func configureSubviews() {
        contentView.addSubview(cardImageView)
        contentView.addSubview(moneyLabel)
        contentView.addSubview(cardLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(emptyLabel)
    }

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

        cardLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(202)
            $0.centerX.equalToSuperview()
        }

        contentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(227)
            $0.centerX.equalToSuperview()
        }

        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
