//
//  MyPageTableViewCell.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/15.
//

import UIKit

final class MyPageTableViewCell: UITableViewCell {

    static let identifier = "MyPageTableViewCell"

    // MARK: UI Components
    private(set) var contentLabel = UILabel().then {
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 14)
    }

    private(set) var detailButton = BaseButton().then {
        $0.setImage(UIImage(named: "detailButton"), for: .normal)
    }

    // MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configuration
    func configureSubviews() {
        contentView.addSubview(contentLabel)
        contentView.addSubview(detailButton)
    }
    
    // MARK: Layout
    func makeConstraints() {
        contentLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(28)
            $0.centerY.equalToSuperview()
        }

        detailButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(28)
            $0.centerY.equalToSuperview()
        }
    }
}
