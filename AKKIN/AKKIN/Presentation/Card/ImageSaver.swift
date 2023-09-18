//
//  ImageSaver.swift
//  AKKIN
//
//  Created by SJW on 2023/09/17.
//

import UIKit
import Photos

class ImageSaver: NSObject {
    private var isPermissionDenied = false
    private var imageSavedHandler: (() -> Void)?
    private var viewController: UIViewController?
    
    /* 이미지 저장 */
    func saveImage(_ image: UIImage, target: UIViewController? = nil, handler: (() -> Void)? = nil) {
        imageSavedHandler = handler
        viewController = target
        
        isPermissionDenied = checkPhotoPermission()
        UIImageWriteToSavedPhotosAlbum(image,
                                       self,
                                       #selector(imageSaved(image:didFinishSavingWithError:contextInfo:)),
                                       nil)
    }
    
    /* 이미지 저장 후 */
    @objc func imageSaved(image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            NSLog("Failed to save image. Error = \(error.localizedDescription)")
            if isPermissionDenied, let _ = viewController {
                //Dialog.presentPhotoPermission(vc)
            }
        } else {
            imageSavedHandler?()
        }
    }
    
    /* 권한 체크 */
    private func checkPhotoPermission() -> Bool {
        var status: PHAuthorizationStatus = .notDetermined
        if #available(iOS 14, *) {
            status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
        } else {
            status = PHPhotoLibrary.authorizationStatus()
        }
        return status == .denied
    }
}

extension UIView {
    /* UIImage로 변환 */
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
