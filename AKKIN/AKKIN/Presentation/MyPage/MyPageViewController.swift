//
//  MyPageViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/15.
//

import UIKit
import SafariServices

final class MyPageViewController: BaseViewController {

    private let headerTitle = ["가입된 계정", "앱 정보", "계정 관리"]
    private let appInfo = ["서비스 이용약관", "개인 정보 처리 방침", "오픈소스 사용정보"]
    private let account = ["로그아웃", "회원탈퇴"]
    private var nickName = "거지"
    private let url = [URLConst.termsURL,
                       URLConst.privacyPolicyURL,
                       URLConst.openSourceURL]

    // MARK: UI Components
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

    private func presentSafariView(url: String) {
        guard let url = URL(string: url) else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }

    private func presentAlert(
        title: String,
        message: String?,
        cancelButton: String,
        actionButton: String,
        style: UIAlertAction.Style,
        handler: ((UIAlertAction) -> Void)?
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        let cancelButton = UIAlertAction(
            title: cancelButton,
            style: .default)
        let actionButton = UIAlertAction(
            title: actionButton,
            style: style,
            handler: handler)
        
        alertController.addAction(cancelButton)
        alertController.addAction(actionButton)

        present(alertController, animated: true)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        myPageTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.trailing.bottom.equalTo(view.safeAreaInsets)
        }
    }

    private func logout() {
        router.popToRootViewController()
    }

    private func withdrawal() {
        router.popToRootViewController()
    }
}

extension MyPageViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        default:
            return 2
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myPageTableView.dequeueReusableCell(withIdentifier: MyPageTableViewCell.identifier, for: indexPath) as? MyPageTableViewCell else { return UITableViewCell() }

        switch indexPath.section {
        case 0:
            cell.contentLabel.text = "${mail}"
            cell.detailButton.isHidden = true
        case 1:
            cell.contentLabel.text = appInfo[indexPath.row]
        case 2:
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

        if section == 0 {
            header.dividerView.isHidden = true
            header.titleLabel.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.leading.equalToSuperview().inset(28)
            }
        }
        header.titleLabel.text = headerTitle[section]

        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 33
        } else {
            return 73
        }
    }
}

extension MyPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            presentSafariView(url: url[indexPath.row])
        case 2:
            switch indexPath.row {
            case 0:
                presentAlert(
                    title: "로그아웃하시겠어요?",
                    message: nil,
                    cancelButton: "취소",
                    actionButton: "확인",
                    style: .cancel,
                    handler: { action in self.logout() }
                )
            case 1:
                presentAlert(
                    title: "정말 탈퇴하시겠어요?",
                    message: "이 동작은 취소할 수 없어요.",
                    cancelButton: "취소",
                    actionButton: "탈퇴하기",
                    style: .destructive,
                    handler: { action in self.withdrawal() }
                )
            default:
                break
            }
        default:
            break
        }
    }
}

extension UITextField {
    func underlined(viewSize: CGFloat, color: UIColor){
        let border = CALayer()
        let width = CGFloat(0.34)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height + 29, width: viewSize - 48, height: width)
        border.borderWidth = width
        self.layer.addSublayer(border)
    }

    func addLeftPadding() {
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: self.frame.height))
      self.leftView = paddingView
      self.leftViewMode = ViewMode.always
    }
}
