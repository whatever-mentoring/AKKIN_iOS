//
//  CardDetailViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/26.
//

import UIKit

class CardDetailViewController: BaseViewController {
    
    // MARK: UI Components
    private let backButton = BaseButton().then {
        $0.setImage(AkkinButton.backButton, for: .normal)
    }

    private let optionButton = BaseButton().then {
        $0.setImage(AkkinButton.optionButton, for: .normal)
    }

    private let cardDetailView = CardDetailView()
    
    // MARK: Environment
    private let router = ExampleRouter()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        view.backgroundColor = .akkinGray0
        router.viewController = self
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        view.addSubview(cardDetailView)

        backButton.tap = { [weak self] in
            guard let self else { return }
            router.dismissViewController()
        }

        optionButton.tap = { [weak self] in
            guard let self else { return }
            presentActionSheet()
        }
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        cardDetailView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(58)
            $0.centerX.equalToSuperview()
        }
    }

    private func setNavigationItem() {
        navigationItem.title = "카드 상세 내용"

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: optionButton)
    }

    private func presentActionSheet() {
        let actionsheetController = UIAlertController(title: "카드 상세 내용", message: nil, preferredStyle: .actionSheet)

        let patchButton = UIAlertAction(
            title: "수정",
            style: .default,
            handler: { [self]
                _ in router.presentCardPatchViewController()
        })

        let deleteButton = UIAlertAction(
            title: "삭제",
            style: .destructive,
            handler: { [self]
                _ in presentAlert()
        })

        let cancelButton = UIAlertAction(title: "닫기", style: .cancel, handler: nil)

        actionsheetController.addAction(patchButton)
        actionsheetController.addAction(deleteButton)
        actionsheetController.addAction(cancelButton)

        present(actionsheetController, animated: true, completion: nil)
    }

    private func presentAlert() {
        let alertController = UIAlertController(title: "카드를 정말 삭제할까요?", message: "이 동작은 취소할 수 없어요.", preferredStyle: .alert)

        let deleteButton = UIAlertAction(
            title: "삭제",
            style: .destructive,
            handler: {
                action in print("삭제")
        })

        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alertController.addAction(deleteButton)
        alertController.addAction(cancelButton)

        present(alertController, animated: true, completion: nil)
    }
}
