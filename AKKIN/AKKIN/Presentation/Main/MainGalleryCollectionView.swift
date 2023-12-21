//
//  MainGalleryCollectionView.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/12/21.
//

import UIKit

final class MainGalleryCollectionView: BaseView {

    var totalEntries: [Entries] = []
    var diningEntries: [Entries] = []
    var trafficEntries: [Entries] = []
    var shoppingEntries: [Entries] = []
    var etcEntries: [Entries] = []
    var selectedTotalEntries: [Entries] = []

    // MARK: UI Components
    private let categoryButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }

    private let totalButton = BaseButton().then {
        $0.setTitle("전체", for: .normal)
        $0.isSelected = true
        $0.setTitleColor(.black, for: .normal)
        $0.setTitleColor(.white, for: .selected)
        $0.backgroundColor = UIColor.akkinGreen
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.layer.cornerRadius = 17
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.13
        $0.layer.shadowOffset = CGSize(width: 1, height: 2)
        $0.layer.shadowRadius = 4
    }
    
    private let diningButton = BaseButton().then {
        $0.setTitle("식비", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.setTitleColor(.white, for: .selected)
        $0.backgroundColor = UIColor.akkinGreen
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.layer.cornerRadius = 17
        $0.backgroundColor = .akkinWhite
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.akkinGray3.cgColor
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.13
        $0.layer.shadowOffset = CGSize(width: 1, height: 2)
        $0.layer.shadowRadius = 4
    }
    
    private let trafficButton = BaseButton().then {
        $0.setTitle("교통", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.setTitleColor(.white, for: .selected)
        $0.backgroundColor = UIColor.akkinGreen
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.layer.cornerRadius = 17
        $0.backgroundColor = .akkinWhite
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.akkinGray3.cgColor
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.13
        $0.layer.shadowOffset = CGSize(width: 1, height: 2)
        $0.layer.shadowRadius = 4
    }
    
    private let shoppingButton = BaseButton().then {
        $0.setTitle("쇼핑", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.setTitleColor(.white, for: .selected)
        $0.backgroundColor = UIColor.akkinGreen
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.layer.cornerRadius = 17
        $0.backgroundColor = .akkinWhite
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.akkinGray3.cgColor
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.13
        $0.layer.shadowOffset = CGSize(width: 1, height: 2)
        $0.layer.shadowRadius = 4
    }
    
    private let etcButton = BaseButton().then {
        $0.setTitle("기타", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.setTitleColor(.white, for: .selected)
        $0.backgroundColor = UIColor.akkinGreen
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.layer.cornerRadius = 17
        $0.backgroundColor = .akkinWhite
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.akkinGray3.cgColor
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.13
        $0.layer.shadowOffset = CGSize(width: 1, height: 2)
        $0.layer.shadowRadius = 4
    }

    public lazy var galleryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(MainGalleryCollectionViewCell.self, forCellWithReuseIdentifier: MainGalleryCollectionViewCell.identifier)
        
        return collectionView
    }()

    // MARK: Properties
    var tapCell: (([Entries]) -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        getMain()

        totalButton.addTarget(self, action: #selector(totalButtonTapped), for: .touchUpInside)
        diningButton.addTarget(self, action: #selector(diningButtonTapped), for: .touchUpInside)
        trafficButton.addTarget(self, action: #selector(trafficButtonTapped), for: .touchUpInside)
        shoppingButton.addTarget(self, action: #selector(shoppingButtonTapped), for: .touchUpInside)
        etcButton.addTarget(self, action: #selector(etcButtonTapped), for: .touchUpInside)

        galleryCollectionView.dataSource = self
        galleryCollectionView.delegate = self
        galleryCollectionView.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1)

        addSubview(categoryButtonStackView)
        addSubview(galleryCollectionView)
        categoryButtonStackView.addArrangedSubview(totalButton)
        categoryButtonStackView.addArrangedSubview(diningButton)
        categoryButtonStackView.addArrangedSubview(trafficButton)
        categoryButtonStackView.addArrangedSubview(shoppingButton)
        categoryButtonStackView.addArrangedSubview(etcButton)
    }
    
    @objc func totalButtonTapped() {
        if !totalButton.isSelected {
            totalButton.isSelected = true
            totalButton.setTitleColor(.white, for: .selected)
            totalButton.backgroundColor = UIColor.akkinGreen
        }

        diningButton.isSelected = false
        trafficButton.isSelected = false
        shoppingButton.isSelected = false
        etcButton.isSelected = false

        diningButton.backgroundColor = UIColor.white
        trafficButton.backgroundColor = UIColor.white
        shoppingButton.backgroundColor = UIColor.white
        etcButton.backgroundColor = UIColor.white

        galleryCollectionView.reloadData()
    }

    @objc func diningButtonTapped() {
        if !diningButton.isSelected {
            diningButton.isSelected = true
            diningButton.setTitleColor(.white, for: .selected)
            diningButton.backgroundColor = UIColor.akkinGreen
        }

        totalButton.isSelected = false
        trafficButton.isSelected = false
        shoppingButton.isSelected = false
        etcButton.isSelected = false

        totalButton.backgroundColor = UIColor.white
        trafficButton.backgroundColor = UIColor.white
        shoppingButton.backgroundColor = UIColor.white
        etcButton.backgroundColor = UIColor.white

        diningEntries = totalEntries.filter { $0.category == "DINING" }
        galleryCollectionView.reloadData()
    }

    @objc func trafficButtonTapped() {
        if !trafficButton.isSelected {
            trafficButton.isSelected = true
            trafficButton.setTitleColor(.white, for: .selected)
            trafficButton.backgroundColor = UIColor.akkinGreen
        }

        totalButton.isSelected = false
        diningButton.isSelected = false
        shoppingButton.isSelected = false
        etcButton.isSelected = false

        totalButton.backgroundColor = UIColor.white
        diningButton.backgroundColor = UIColor.white
        shoppingButton.backgroundColor = UIColor.white
        etcButton.backgroundColor = UIColor.white

        trafficEntries = totalEntries.filter { $0.category == "TRAFFIC" }
        galleryCollectionView.reloadData()
    }

    @objc func shoppingButtonTapped() {
        if !shoppingButton.isSelected {
            shoppingButton.isSelected = true
            shoppingButton.setTitleColor(.white, for: .selected)
            shoppingButton.backgroundColor = UIColor.akkinGreen
        }

        totalButton.isSelected = false
        diningButton.isSelected = false
        trafficButton.isSelected = false
        etcButton.isSelected = false

        totalButton.backgroundColor = UIColor.white
        diningButton.backgroundColor = UIColor.white
        trafficButton.backgroundColor = UIColor.white
        etcButton.backgroundColor = UIColor.white

        shoppingEntries = totalEntries.filter { $0.category == "SHOPPING" }
        galleryCollectionView.reloadData()
    }

    @objc func etcButtonTapped() {
        if !etcButton.isSelected {
            etcButton.isSelected = true
            etcButton.setTitleColor(.white, for: .selected)
            etcButton.backgroundColor = UIColor.akkinGreen
        }

        totalButton.isSelected = false
        diningButton.isSelected = false
        trafficButton.isSelected = false
        shoppingButton.isSelected = false

        totalButton.backgroundColor = UIColor.white
        diningButton.backgroundColor = UIColor.white
        trafficButton.backgroundColor = UIColor.white
        shoppingButton.backgroundColor = UIColor.white

        etcEntries = totalEntries.filter { $0.category == "ETC" }
        galleryCollectionView.reloadData()
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        categoryButtonStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalToSuperview().inset(25)
            $0.width.equalTo(272)
            $0.height.equalTo(33)
        }

        totalButton.snp.makeConstraints {
            $0.width.equalTo(48)
            $0.height.equalTo(33)
        }

        diningButton.snp.makeConstraints {
            $0.width.equalTo(48)
            $0.height.equalTo(33)
        }

        trafficButton.snp.makeConstraints {
            $0.width.equalTo(48)
            $0.height.equalTo(33)
        }

        shoppingButton.snp.makeConstraints {
            $0.width.equalTo(48)
            $0.height.equalTo(33)
        }

        etcButton.snp.makeConstraints {
            $0.width.equalTo(48)
            $0.height.equalTo(33)
        }

        galleryCollectionView.snp.makeConstraints {
            $0.top.equalTo(categoryButtonStackView.snp.bottom).offset(24)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: Event
    func handleCellEvent(_ selectedEntries: [Entries]) {
        tapCell?(selectedEntries)
    }
}

extension MainGalleryCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if mainEntries.count == 0 {
//            return 1
//        } else {
//        return firstPageEntries.count
//        }
        if totalButton.isSelected {
            return totalEntries.count
        } else if diningButton.isSelected {
            return diningEntries.count
        } else if trafficButton.isSelected {
            return trafficEntries.count
        } else if shoppingButton.isSelected {
            return shoppingEntries.count
        } else {
            return etcEntries.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = galleryCollectionView.dequeueReusableCell(withReuseIdentifier: MainGalleryCollectionViewCell.identifier, for: indexPath) as? MainGalleryCollectionViewCell else { return UICollectionViewCell() }
        //        if mainEntries.count == 0 {
        //            cell.cardImageView.isHidden = true
        //            cell.moneyLabel.isHidden = true
        //            cell.cardLabel.isHidden = true
        //            cell.contentLabel.isHidden = true
        //            cell.emptyLabel.isHidden = false
        //            cell.contentView.layer.borderColor = UIColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 1).cgColor
        //            cell.contentView.layer.borderWidth = 1
        //            cell.contentView.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1)
        //            cell.contentView.layer.shadowColor = UIColor.clear.cgColor
        //            cardCollectionView.reloadData()
        //        } else {

        var entry = totalEntries[indexPath.row]

        if diningButton.isSelected {
            entry = diningEntries[indexPath.row]
        } else if trafficButton.isSelected {
            entry = trafficEntries[indexPath.row]
        } else if shoppingButton.isSelected {
            entry = shoppingEntries[indexPath.row]
        } else if etcButton.isSelected {
            entry = etcEntries[indexPath.row]
        }

        cell.cardImageView.image = AkkinImage.akkinIcon1
        cell.saveContentLabel.text = "[ " + "\(entry.how)" + " ]"
        cell.howLabel.text = entry.saveContent
        //        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = 163
        let height: CGFloat = 215
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let edgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 24, right: 24)
        return edgeInsets
    }
}

extension MainGalleryCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        var entry = totalEntries[indexPath.row]

        if diningButton.isSelected {
            entry = diningEntries[indexPath.row]
        } else if trafficButton.isSelected {
            entry = trafficEntries[indexPath.row]
        } else if shoppingButton.isSelected {
            entry = shoppingEntries[indexPath.row]
        } else if etcButton.isSelected {
            entry = etcEntries[indexPath.row]
        }

        selectedTotalEntries = totalEntries.filter { $0.id == entry.id }
        handleCellEvent(selectedTotalEntries)
    }
}

extension MainGalleryCollectionView {
    // MARK: Networking
    private func getMain() {
        print("gallery - getMain called")
        NetworkService.shared.main.getMain() { result in
            switch result {
            case .success(let response):
                guard let data = response as? MainResponse else { return }
                self.totalEntries = data.firstPage.entries
                print("gallery - getMain data" + "\(data)")
                print("gallery - getMain firstPageEntries" + "\(self.totalEntries)")
                self.galleryCollectionView.reloadData()
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
