//
//  UIViewController + Extension.swift
//  AKKIN
//
//  Created by SJW on 2023/09/24.
//


import UIKit

import SnapKit

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
