//
//  MyPageTableViewHeader.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/17.
//

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
    private(set) var dividerView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.99, alpha: 1)
    }

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
    func configureSubviews() {
        contentView.addSubview(dividerView)
        contentView.addSubview(titleLabel)
    }

    // MARK: Layout
    func makeConstraints() {
        dividerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(12)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.leading.equalToSuperview().inset(28)
        }
    }
}
