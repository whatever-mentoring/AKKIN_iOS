//
//  MainGalleryCollectionView.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/12/21.
//

import UIKit

final class MainGalleryCollectionView: BaseView {

    var firstPageEntries: [FirstPageEntries] = []

    // MARK: UI Components
    private let categoryButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }

    private let totalButton = BaseButton().then {
        $0.setTitle("전체", for: .normal)
        $0.setTitleColor(.white, for: .normal)
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
    var tapAdd: (() -> Void)?
    var tapCell: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        getMain()
        print("printtttt" + "\(firstPageEntries)")

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
    @objc private func handleAddEvent() {
        tapAdd?()
    }

    func handleCellEvent() {
        tapCell?()
    }
}

extension MainGalleryCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if mainEntries.count == 0 {
//            return 1
//        } else {
        return firstPageEntries.count
//        }
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
            let entry = firstPageEntries[indexPath.row]
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
        handleCellEvent()
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
                self.firstPageEntries = data.firstPage.entries
                print("gallery - getMain data" + "\(data)")
                print("?gallery - getMain firstPageEntries" + "\(self.firstPageEntries)")
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
