//
//  CardSaveViewController.swift
//  AKKIN
//
//  Created by SJW on 2023/09/16.
//

import UIKit
import Photos
import Toast

class CardSaveViewController: BaseViewController {

    var selectedYear: Int?
    var selectedMonth: Int?
    var selectedDay: Int?
    var selectedImage: UIImage?
    var selectedSaveContent: String?
    var selectedHow: String?
    var selectedExpectCost: Int?
    var selectedRealCost: Int?

    // MARK: UI Components
    private let cardSavePageView = CardSavePageView()

    // MARK: Environment
    private let router = ExampleRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .akkinBG

        cardSavePageView.configureCardSaveView(
            selectedYear: selectedYear,
            selectedMonth: selectedMonth,
            selectedDay: selectedDay,
            selectedImage: selectedImage,
            selectedSaveContent: selectedSaveContent,
            selectedHow: selectedHow,
            selectedExpectCost: selectedExpectCost,
            selectedRealCost: selectedRealCost
        )

        router.viewController = self
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        view.addSubview(cardSavePageView)

        cardSavePageView.tap = { [weak self] in
            guard let self else { return }
            router.popToRootViewController()
        }

        cardSavePageView.tapImage = { [weak self] in
            guard let self else { return };
            saveCardAsImage()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        cardSavePageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func saveCardAsImage() {
        let cardImage = cardSavePageView.saveCardViewAsImage()

        let completionHandler: (UIImage?, Error?, UnsafeMutableRawPointer?) -> Void = { image, error, context in
            if let error = error {
                print("이미지 저장 실패: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.view.makeToast(AkkinString.saveSuccessToast, duration: 1.0, position: .bottom)
                }
            }
        }

        let context = UnsafeMutableRawPointer.allocate(byteCount: 0, alignment: 1)

        if #available(iOS 15.0, *) {
            if let cgImage = cardImage.cgImage {
                let uiImage = UIImage(cgImage: cgImage)

                PHPhotoLibrary.shared().performChanges {
                    PHAssetChangeRequest.creationRequestForAsset(from: uiImage)
                } completionHandler: { success, error in
                    if success {
                        completionHandler(uiImage, nil, context)
                    } else if let error = error {
                        completionHandler(nil, error, context)
                    }
                }
            }
        } else {
            print("iOS 15 이상에서만 지원됩니다.")
        }
    }
}
