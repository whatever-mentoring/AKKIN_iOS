//
//  CardDetailViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/26.
//

import UIKit

class CardDetailViewController: BaseViewController {

    var selectedEntries: [MainEntries] = []

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

        view.backgroundColor = .akkinBG
        router.viewController = self
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        view.addSubview(cardDetailView)
        setNavigationItem()
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

    private func setNavigationItem() {
        navigationItem.title = AkkinString.cardDetail

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: optionButton)
    }

    private func setCardContent() {
        cardDetailView.iconImageView.image = UIImage(named: selectedEntries[0].imageUrl ?? "icon_1")
        cardDetailView.dateTextLabel.text = "\(selectedEntries[0].year)" + "." + "\(selectedEntries[0].month)" + "." + "\(selectedEntries[0].day)"
        cardDetailView.savePriceLabel.text = "무려 " + "\((selectedEntries[0].expectCost - selectedEntries[0].realCost).toPriceFormat)" + " 원"
        cardDetailView.saveContentLabel.text = "[ " + "\(selectedEntries[0].saveContent)" + " ]"
        cardDetailView.howLabel.text = selectedEntries[0].how
        cardDetailView.expectPriceLabel.text = "\(selectedEntries[0].expectCost.toPriceFormat)"
        cardDetailView.realPriceLabel.text = "\(selectedEntries[0].realCost.toPriceFormat)"
        if selectedEntries[0].gulbiCategory == AkkinString.DINING {
            cardDetailView.diningButton.setTitleColor(.white, for: .normal)
            cardDetailView.diningButton.backgroundColor = .akkinGreen
        } else if selectedEntries[0].gulbiCategory == AkkinString.TRAFFIC {
            cardDetailView.trafficButton.setTitleColor(.white, for: .normal)
            cardDetailView.trafficButton.backgroundColor = .akkinGreen
        } else if selectedEntries[0].gulbiCategory == AkkinString.SHOPPING {
            cardDetailView.shoppingButton.setTitleColor(.white, for: .normal)
            cardDetailView.shoppingButton.backgroundColor = .akkinGreen
        } else if selectedEntries[0].gulbiCategory == AkkinString.ETC {
            cardDetailView.etcButton.setTitleColor(.white, for: .normal)
            cardDetailView.etcButton.backgroundColor = .akkinGreen
        } else {
            print("category is nil" + "\(selectedEntries[0].gulbiCategory)")
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

    // MARK: ActionSheet
    private func presentActionSheet() {
        let actionsheetController = UIAlertController(title: AkkinString.cardDetail, message: nil, preferredStyle: .actionSheet)

        let patchButton = UIAlertAction(
            title: AkkinString.patchGulbis,
            style: .default,
            handler: { [self]
                _ in router.presentCardPatchViewController(selectedEntries: selectedEntries)
        })

        let deleteButton = UIAlertAction(
            title: AkkinString.deleteGulbis,
            style: .destructive,
            handler: { [self]
                _ in presentAlert()
        })

        let cancelButton = UIAlertAction(title: AkkinString.cancel, style: .cancel, handler: nil)

        actionsheetController.addAction(patchButton)
        actionsheetController.addAction(deleteButton)
        actionsheetController.addAction(cancelButton)

        present(actionsheetController, animated: true, completion: nil)
    }

    // MARK: Alert
    private func presentAlert() {
        let alertController = UIAlertController(title: AkkinString.cardDeleteTitle, message: AkkinString.cardDeleteMessage, preferredStyle: .alert)

        let deleteButton = UIAlertAction(
            title: AkkinString.deleteGulbis,
            style: .destructive,
            handler: { [self]
                action in deleteGulbis(selectedEntries[0].id)
        })

        let cancelButton = UIAlertAction(title: AkkinString.cancel, style: .cancel, handler: nil)

        alertController.addAction(deleteButton)
        alertController.addAction(cancelButton)

        present(alertController, animated: true, completion: nil)
    }

    // MARK: Networking
    private func deleteGulbis(_ id: Int) {
        print("💸 deleteGulbis called")
        NetworkService.shared.gulbis.deleteGulbis(id: id) { result in
            switch result {
            case .success:
                print("🎯 deleteGulbis success")
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
