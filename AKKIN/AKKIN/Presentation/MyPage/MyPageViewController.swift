//
//  MyPageViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/15.
//

import UIKit

final class MyPageViewController: BaseViewController {

    private let headerTitle = ["앱 정보", "계정 관리"]
    private let appInfo = ["서비스 이용약관", "개인 정보 처리 방침", "오픈소스 사용정보"]
    private let account = ["로그아웃", "회원탈퇴"]

    // MARK: UI Components
    private let profileImageView = UIImageView().then {
        $0.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.99, alpha: 1)
        $0.layer.cornerRadius = 70
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.14, green: 0.68, blue: 0.37, alpha: 1).cgColor
    }

    private let nameLabel = UILabel().then {
        $0.text = "이름이 들어갑니다"
        $0.font = UIFont.systemFont(ofSize: 20)
    }

    private let editButton = BaseButton().then {
        $0.setImage(UIImage(named: "editButton"), for: .normal)
    }

    private let myPageTableView = UITableView().then {
        $0.register(MyPageTableViewCell.self, forCellReuseIdentifier: MyPageTableViewCell.identifier)
        $0.register(MyPageTableViewHeader.self, forHeaderFooterViewReuseIdentifier: MyPageTableViewHeader.identifier)
        $0.isScrollEnabled = false
        $0.separatorStyle = .none
    }

    private let backButton = BaseButton().then {
        $0.setImage(UIImage(named: "backButton"), for: .normal)
    }

    // MARK: Environment
    private let router = ExampleRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()

        router.viewController = self
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        myPageTableView.dataSource = self
        myPageTableView.delegate = self

        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(editButton)
        view.addSubview(myPageTableView)

        backButton.tap = { [weak self] in
            guard let self else { return }
            router.dismissViewController()
        }
    }

    private func setNavigationItem() {
        navigationItem.title = "마이페이지"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(140)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(177)
            $0.centerX.equalToSuperview().offset(-2)
        }

        editButton.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(2)
            $0.centerY.equalTo(nameLabel.snp.centerY)
            $0.width.height.equalTo(20)
        }

        myPageTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(220)
            $0.leading.trailing.bottom.equalTo(view.safeAreaInsets)
        }
    }
}

extension MyPageViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        default:
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myPageTableView.dequeueReusableCell(withIdentifier: MyPageTableViewCell.identifier, for: indexPath) as? MyPageTableViewCell else { return UITableViewCell() }

        switch indexPath.section {
        case 0:
            cell.contentLabel.text = appInfo[indexPath.row]
        case 1:
            cell.contentLabel.text = account[indexPath.row]
            cell.detailButton.isHidden = true
            switch indexPath.row {
            case 1:
                cell.contentLabel.font = UIFont.systemFont(ofSize: 14)
                cell.contentLabel.textColor = UIColor(red: 0.72, green: 0.72, blue: 0.72, alpha: 1)
            default:
                break
            }
        default:
            break
        }

        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = myPageTableView.dequeueReusableHeaderFooterView(withIdentifier: MyPageTableViewHeader.identifier) as? MyPageTableViewHeader else { return UITableViewHeaderFooterView() }
        
        header.titleLabel.text = headerTitle[section]

        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 73
    }
}
