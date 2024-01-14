//
//  CardSaveViewController.swift
//  AKKIN
//
//  Created by SJW on 2023/09/16.
//

import UIKit
import Photos
import Toast
import KakaoSDKShare
import KakaoSDKTemplate
import KakaoSDKCommon

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

        cardSavePageView.tapShareButton = { [weak self] in
            guard let self else { return };
            sharedTextTemplate(selectedYear: selectedYear, selectedMonth: selectedMonth, selectedDay: selectedDay, selectedImage: selectedImage, selectedSaveContent: selectedSaveContent, selectedHow: selectedHow, selectedExpectCost: selectedExpectCost, selectedRealCost: selectedRealCost)
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        cardSavePageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func sharedTextTemplate(
        selectedYear: Int?,
        selectedMonth: Int?,
        selectedDay: Int?,
        selectedImage: UIImage?,
        selectedSaveContent: String?,
        selectedHow: String?,
        selectedExpectCost: Int?,
        selectedRealCost: Int?) {
            if let year = selectedYear,
               let month = selectedMonth,
               let day = selectedDay,
               let image = selectedImage,
               let saveContent = selectedSaveContent,
               let how = selectedHow,
               let expectCost = selectedExpectCost,
               let realCost = selectedRealCost
            {
                let title = "[\(how)]"
                let script =  "\((expectCost - realCost).toPriceFormat.toMoney)원 아낌"
                if ShareApi.isKakaoTalkSharingAvailable() {
                    let appLink = Link(iosExecutionParams: ["second": "vvv"])
                    let button = Button(title: "앱에서 보기", link: appLink)
                    let content = Content(
                        title: title,
                        imageUrl: URL(string: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.facebook.com%2Fwjfunfun%2Fphotos%2Fa.307233546109396%2F373916449441105%2F%3Ftype%3D3&psig=AOvVaw1f0tAuzSOX6cmdHMxK-k75&ust=1705321231841000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCJDWq-Tu3IMDFQAAAAAdAAAAABAD")!,
                        description: script,
                        link: appLink)
                    let template = FeedTemplate(content: content, buttons: [button])

                    if let templateJsonData = (try? SdkJSONEncoder.custom.encode(template)) {
                        if let templateJsonObject = SdkUtils.toJsonObject(templateJsonData) {
                            ShareApi.shared.shareDefault(templateObject:templateJsonObject) {(linkResult, error) in
                                if let error = error {
                                    print("error : \(error)")
                                }
                                else {
                                    print("defaultLink(templateObject:templateJsonObject) success.")
                                    guard let linkResult = linkResult else { return }
                                    UIApplication.shared.open(linkResult.url, options: [:], completionHandler: nil)
                                }
                            }
                        }
                    }
                }
                else {
                    print("카카오톡 미설치")
                }
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
