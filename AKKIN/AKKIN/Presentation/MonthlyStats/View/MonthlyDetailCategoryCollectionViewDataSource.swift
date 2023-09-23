//
//  MonthlyDetailCategoryCollectionViewDataSource.swift
//  AKKIN
//
//  Created by SJW on 2023/09/24.
//

import Foundation
import UIKit

class MonthlyDetailCategoryCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    private var categoryItems: [CategoryItem] = []
    
    override init() {
        super.init()
    }
    
    func setCategoryItems(forCategory category: String) {
        // 해당 카테고리에 맞는 더미 데이터를 설정합니다.
        // 예를 들어, "DINING" 카테고리에 대한 데이터를 설정하는 코드를 작성합니다.
        
        switch category {
        case "DINING":
            categoryItems = [
                CategoryItem(name: "식비1", amount: 20000),
                CategoryItem(name: "식비2", amount: 25000),
                // 다른 식비 항목들 추가
            ]
        case "TRAFFIC":
            categoryItems = [
                CategoryItem(name: "교통1", amount: 15000),
                CategoryItem(name: "교통2", amount: 18000),
                // 다른 교통 항목들 추가
            ]
        case "SHOPPING":
            categoryItems = [
                CategoryItem(name: "쇼핑1", amount: 30000),
                CategoryItem(name: "쇼핑2", amount: 45000),
                // 다른 쇼핑 항목들 추가
            ]
        case "ETC":
            categoryItems = [
                CategoryItem(name: "기타1", amount: 5000),
                CategoryItem(name: "기타2", amount: 8000),
                // 다른 기타 항목들 추가
            ]
        default:
            // 처리하지 않은 다른 카테고리에 대한 기본 데이터 설정
            categoryItems = []
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthlyDetailCategoryListCell.identifier, for: indexPath) as? MonthlyDetailCategoryListCell else {
            fatalError("Failed to dequeue CategoryItemCell")
        }
        
        let item = categoryItems[indexPath.item]
        cell.configure(with: item)
        
        return cell
    }
}



