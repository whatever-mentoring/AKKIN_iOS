//
//  String+Extension.swift
//  AKKIN
//
//  Created by 박지윤 on 2024/01/09.
//

import Foundation

extension String {
    var toSaveContent: String {
        return "[ " + self + " ]"
    }

    var toMoney: String {
        return "무려 " + self + " 원"
    }
}
