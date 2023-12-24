//
//  CardDetailViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/26.
//

import UIKit

class CardDetailViewController: BaseViewController {

    var selectedEntries: [Entries] = []

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

        setCardContent()

        backButton.tap = { [weak self] in
            guard let self else { return }
            router.dismissViewController()
        }

        optionButton.tap = { [weak self] in
            guard let self else { return }
            presentActionSheet()
        }
    }

    private func setCardContent() {
        cardDetailView.dateTextLabel.text = "\(selectedEntries[0].year)" + "." + "\(selectedEntries[0].month)" + "." + "\(selectedEntries[0].day)"
        cardDetailView.savePriceLabel.text = "무려 " + "\(selectedEntries[0].expectCost - selectedEntries[0].realCost)" + " 원"
        cardDetailView.saveContentLabel.text = "[ " + "\(selectedEntries[0].saveContent)" + " ]"
        cardDetailView.howLabel.text = selectedEntries[0].how
        cardDetailView.expectPriceLabel.text = "\(selectedEntries[0].expectCost)"
        cardDetailView.realPriceLabel.text = "\(selectedEntries[0].realCost)"
        if selectedEntries[0].category == "DINING" {
            cardDetailView.diningButton.setTitleColor(.white, for: .normal)
            cardDetailView.diningButton.backgroundColor = .akkinGreen
        } else if selectedEntries[0].category == "TRAFFIC" {
            cardDetailView.trafficButton.setTitleColor(.white, for: .normal)
            cardDetailView.trafficButton.backgroundColor = .akkinGreen
        } else if selectedEntries[0].category == "SHOPPING" {
            cardDetailView.shoppingButton.setTitleColor(.white, for: .normal)
            cardDetailView.shoppingButton.backgroundColor = .akkinGreen
        } else if selectedEntries[0].category == "ETC" {
            cardDetailView.etcButton.setTitleColor(.white, for: .normal)
            cardDetailView.etcButton.backgroundColor = .akkinGreen
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
                _ in router.presentCardPatchViewController(selectedEntries: selectedEntries)
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
            handler: { [self]
                action in deleteAkkin(selectedEntries[0].id)
        })

        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alertController.addAction(deleteButton)
        alertController.addAction(cancelButton)

        present(alertController, animated: true, completion: nil)
    }

    // MARK: Networking
    private func deleteAkkin(_ id: Int) {
        NetworkService.shared.akkin.deleteAkkin(id: id) { result in
            switch result {
            case .success(let response):
                guard let data = response as? BlankDataResponse else { return }
                print(data)
                self.router.popToRootViewController()
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? ErrorResponse else { return }
                print(data)
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            case .pathErr:
                print("pathErr")
            }
        }
    }
}
