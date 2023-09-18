//
//  WeeklyStatsCategoryCell.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/16.
//
import UIKit

final class WeeklyStatsCategoryCell: UICollectionViewCell {
    
    static let identifier = "WeeklyStatsCategoryCell"
    var categoryButtonAction : (() -> ())?
    var selectedButtonIndex: Int = 0
    var selectedButtonIndexs: Int = 0

    // MARK: UI Components
    private(set) var categoryButton = BaseButton().then {
        $0.setTitle("전체", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.layer.cornerRadius = 17
        $0.backgroundColor = .white
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.13
        $0.layer.shadowOffset = .zero
        $0.isSelected = false
    }
    
    // MARK: Properties
    var tapAdd: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setContentView()
        configureSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setContentView() {
        contentView.backgroundColor = .clear
    }
    
    // MARK: Configuration
    private func configureSubviews() {
        contentView.addSubview(categoryButton)
    }
    
    // MARK: Layout
    private func makeConstraints() {
        categoryButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(48)
            $0.width.equalTo(33)
        }
    }
    
    // MARK: Event
    func selectedCategory() {
        if categoryButton.isSelected == true {
            categoryButton.backgroundColor = UIColor(red: 0.14, green: 0.68, blue: 0.37, alpha: 1)
            categoryButton.setTitleColor(.white, for: .selected)
        }
        else {
            categoryButton.backgroundColor = .white
            categoryButton.setTitleColor(.black, for: .normal)
        }
    }
}
