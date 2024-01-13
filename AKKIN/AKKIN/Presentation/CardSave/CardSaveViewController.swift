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
            sharedTextTemplate()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        cardSavePageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func sharedTextTemplate() {
        if ShareApi.isKakaoTalkSharingAvailable() {
//                let link = Link(webUrl: URL(string:"https://www.naver.com/"),
//                mobileWebUrl: URL(string:"https://www.naver.com/"))

            let appLink = Link(iosExecutionParams: ["second": "vvv"])

            let button = Button(title: "앱에서 보기", link: appLink)

            let content = Content(title: "타이틀 문구",
                                imageUrl: URL(string:"http://mud-kage.kakao.co.kr/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png")!,
                                description: "#케익 #딸기 #삼평동 #카페 #분위기 #소개팅",
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
