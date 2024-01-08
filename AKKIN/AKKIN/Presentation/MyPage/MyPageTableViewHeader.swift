//
//  MyPageTableViewHeader.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/16.
//

import UIKit

final class MyPageTableViewHeader: UITableViewHeaderFooterView {

    static let identifier = "MyPageTableViewHeader"

    // MARK: UI Components
    private(set) var titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }

    // MARK: init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        configureSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configuration
    private func configureSubviews() {
        contentView.addSubview(titleLabel)
    }

    // MARK: Layout
    private func makeConstraints() {
        titleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(28)
        }
    }
}
