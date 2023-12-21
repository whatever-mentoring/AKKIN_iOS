//
//  MyPageTableViewFooter.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/16.
//

import UIKit

final class MyPageTableViewFooter: UITableViewHeaderFooterView {

    static let identifier = "MyPageTableViewFooter"

    // MARK: UI Components
    private(set) var dividerView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.99, alpha: 1)
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
    func configureSubviews() {
        contentView.addSubview(dividerView)
    }

    // MARK: Layout
    func makeConstraints() {
        dividerView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(12)
        }
    }
}
