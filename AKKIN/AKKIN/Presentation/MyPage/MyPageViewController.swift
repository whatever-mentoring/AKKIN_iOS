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
    private var nickName = "거지"

    // MARK: UI Components
    private let profileImageView = UIImageView().then {
        $0.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.99, alpha: 1)
        $0.layer.cornerRadius = 70
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.14, green: 0.68, blue: 0.37, alpha: 1).cgColor
    }

    private let nickNameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20)
    }

    private let nickNameTextField = UITextField().then {
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.isHidden = true
        $0.clearButtonMode = .whileEditing
        $0.tintColor = UIColor(red: 0.14, green: 0.68, blue: 0.37, alpha: 1)
        $0.underlined(viewSize: 200, color: .black)
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

    private let confirmButton = BaseButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(UIColor(red: 0.14, green: 0.68, blue: 0.37, alpha: 1), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)
        $0.isHidden = true
    }

    // MARK: Environment
    private let router = ExampleRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        getNickName()

        router.viewController = self
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        myPageTableView.dataSource = self
        myPageTableView.delegate = self

        view.addSubview(profileImageView)
        view.addSubview(nickNameLabel)
        view.addSubview(nickNameTextField)
        view.addSubview(editButton)
        view.addSubview(myPageTableView)

        backButton.tap = { [weak self] in
            guard let self else { return }
            router.dismissViewController()
        }

        editButton.tap = { [weak self] in
            guard let self else { return }
            self.editButtonTapped()
        }

        confirmButton.tap = { [weak self] in
            guard let self else { return }
            self.confirmButtonTapped()
        }
    }

    private func getNickName() {
        nickNameLabel.text = nickName
        nickNameTextField.placeholder = nickName
    }
 
    private func editButtonTapped() {
        editButton.isHidden = true
        confirmButton.isHidden = false
        nickNameLabel.isHidden = true
        nickNameTextField.isEnabled = true
        nickNameTextField.isHidden = false
        nickNameTextField.text = nickNameLabel.text
    }

    private func confirmButtonTapped() {
        editButton.isHidden = false
        confirmButton.isHidden = true
        nickNameLabel.isHidden = false
        nickNameTextField.isEnabled = false
        nickNameTextField.isHidden = true
        if nickNameTextField.text != "" {
        nickName = nickNameTextField.text ?? nickName
        }
        getNickName()
    }

    private func setNavigationItem() {
        navigationItem.title = "마이페이지"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: confirmButton)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(140)
        }

        nickNameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(177)
            $0.centerX.equalToSuperview().offset(-2)
        }

        nickNameTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(177)
            $0.centerX.equalToSuperview().offset(4)
            $0.width.equalTo(155)
        }

        editButton.snp.makeConstraints {
            $0.leading.equalTo(nickNameLabel.snp.trailing).offset(2)
            $0.centerY.equalTo(nickNameLabel.snp.centerY)
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

extension UITextField {
    func underlined(viewSize: CGFloat, color: UIColor){
        let border = CALayer()
        let width = CGFloat(0.34)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height + 28, width: viewSize - 48, height: width)
        border.borderWidth = width
        self.layer.addSublayer(border)
    }
}
