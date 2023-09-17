//
//  WeeklyStatsWeekCell.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/16.
//

import UIKit

final class WeeklyStatsWeekCell: UICollectionViewCell {

    static let identifier = "WeeklyStatsCollectionViewCell"

    private(set) var dayStringLabel = UILabel().then {
        $0.text = "SUN"
        $0.font = .systemFont(ofSize: 10)
    }

    private let dividerView = UIView().then {
        $0.backgroundColor = .black
    }

    private(set) var dayIntLabel = UILabel().then {
        $0.text = "3"
        $0.font = .systemFont(ofSize: 10)
    }

    private(set) var checkImageView = UIImageView().then {
        $0.image = UIImage(named: "checkButton")
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
        contentView.backgroundColor = .white

    }

    private func configureSubviews() {
        contentView.addSubview(dayStringLabel)
        contentView.addSubview(dividerView)
        contentView.addSubview(dayIntLabel)
        contentView.addSubview(checkImageView)
    }

    private func makeConstraints() {
        dayStringLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).inset(11)
            $0.centerX.equalTo(contentView.snp.centerX)
        }

        dividerView.snp.makeConstraints {
            $0.top.equalTo(contentView).inset(36)
            $0.width.equalTo(contentView)
            $0.height.equalTo(1)
        }
        
        dayIntLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).inset(47)
            $0.centerX.equalToSuperview()
        }

        checkImageView.snp.makeConstraints {
            $0.top.equalTo(contentView).inset(64)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(8)
        }
    }
}
