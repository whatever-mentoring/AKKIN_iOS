//
//  CardViewController.swift
//  AKKIN
//
//  Created by SJW on 2023/09/16.
//

import UIKit
import Photos
import Toast

class CardViewController: BaseViewController {
    var selectedYear: Int?
    var selectedMonth: Int?
    var selectedDay: Int?
    var selectedImage: UIImage?
    var selectedSaveContent: String?
    var selectedHow: String?
    var selectedExpectCost: Int?
    var selectedRealCost: Int?
    
    // MARK: UI Components
    private let cardPageView = CardPageView()
    
    // MARK: Environment
    private let router = ExampleRouter()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .akkinGray0
        
        cardPageView.configureCardView(selectedYear: selectedYear, selectedMonth: selectedMonth, selectedDay: selectedDay, selectedImage: selectedImage, selectedSaveContent: selectedSaveContent, selectedHow: selectedHow, selectedExpectCost: selectedExpectCost, selectedRealCost: selectedRealCost)
        router.viewController = self
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        view.addSubview(cardPageView)
        
        cardPageView.tap = { [weak self] in
            guard let self else { return }
            router.popToRootViewController()
        }
        cardPageView.tapImage = { [weak self] in
            guard let self else { return };
            saveCardAsImage()
        }
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        cardPageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.center.equalToSuperview()
        }
    }
    
    func saveCardAsImage() {
        let cardImage = cardPageView.saveCardViewAsImage()

        // 이미지 저장 완료 또는 실패 시 호출될 콜백
        let completionHandler: (UIImage?, Error?, UnsafeMutableRawPointer?) -> Void = { image, error, context in
            if let error = error {
                // 이미지 저장 중 오류가 발생한 경우 에러 처리
                print("이미지 저장 실패: \(error.localizedDescription)")
            } else {
                // 이미지 저장 성공
                DispatchQueue.main.async {
                    self.view.makeToast(" 이미지가 성공적으로 저장되었습니다. ", duration: 1.0, position: .bottom)
                }
            }
        }

        let context = UnsafeMutableRawPointer.allocate(byteCount: 0, alignment: 1)

        if #available(iOS 15.0, *) {
            // iOS 15 이상에서는 다음을 사용합니다.
            if let cgImage = cardImage.cgImage {
                // CGImage를 UIImage로 변환
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
            // iOS 15 미만의 경우 에러 처리를 추가하거나 다른 방식으로 이미지 저장을 구현할 수 있습니다.
            print("iOS 15 이상에서만 지원됩니다.")
        }
    }

}
