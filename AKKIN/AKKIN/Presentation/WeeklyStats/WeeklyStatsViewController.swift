//
//  WeeklyStatsViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/16.
//
import UIKit

enum Week: CaseIterable {

    case mon
    case tue
    case wed
    case thu
    case fri
    case sat
    case sun

    var title: String {
        switch self {
        case .mon: return "MON"
        case .tue: return "TUE"
        case .wed: return "WED"
        case .thu: return "THU"
        case .fri: return "FRI"
        case .sat: return "SAT"
        case .sun: return "SUN"
        }
    }

    var content: Int {
        switch self {
        case .mon: return 24
        case .tue: return 25
        case .wed: return 26
        case .thu: return 27
        case .fri: return 28
        case .sat: return 29
        case .sun: return 30
        }
    }

    var isExist: Bool {
        switch self {
        case .mon: return false
        case .tue: return false
        case .wed: return true
        case .thu: return false
        case .fri: return false
        case .sat: return false
        case .sun: return false
        }
    }
}

final class WeeklyStatsViewController: BaseViewController {

    var weeklyEntries: [WeeklyEntries] = []

    var onWeekTapped: ((Week) -> Void)?
    let dayLabel = ["3", "4", "5", "6", "7", "8", "9"]
    var weekViewArray: [UIView] = []

    // MARK: UI Components
    private let weekLabel = UILabel().then {
        $0.text = "9월 2주"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }

    private let previousButton = BaseButton().then {
        $0.setImage(AkkinButton.previousButton, for: .normal)
    }

    private let nextButton = BaseButton().then {
        $0.setImage(AkkinButton.detailButton, for: .normal)
    }

    private let backButton = BaseButton().then {
        $0.setImage(AkkinButton.backButton, for: .normal)
    }

    private let weekView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
    }

    private let weekStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }

    // MARK: Environment
    private let router = ExampleRouter()
    private let weeklyStatsCollectionView = WeeklyStatsCollectionView()

    // MARK: ViewDidLoad
    override func loadView() {
        super.loadView()
        getWeekly()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.99, alpha: 1)
        create()
        router.viewController = self
    }

    private func setNavigationItem() {
        navigationItem.title = "주간 통계"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        router.viewController = self

        view.addSubview(weekLabel)
        view.addSubview(previousButton)
        view.addSubview(nextButton)
        view.addSubview(weekView)
        view.addSubview(weeklyStatsCollectionView)

        weekView.addSubview(weekStackView)
    }

    func create() {
        for day in Week.allCases {
            let dayLabel = UILabel()
            dayLabel.text = day.title
            dayLabel.font = UIFont.systemFont(ofSize: 10)
            dayLabel.textColor = .akkinBlack
            dayLabel.textAlignment = .center

            let dividerView = UIView()
            dividerView.backgroundColor = .black

            let dayIntLabel = UILabel()
            dayIntLabel.text = "\(day.content)"
            dayIntLabel.font = UIFont.systemFont(ofSize: 10)
            dayIntLabel.textColor = .akkinBlack
            dayIntLabel.textAlignment = .center

            let dayView = UIView()
            dayView.addSubview(dayLabel)
            dayView.addSubview(dividerView)
            dayView.addSubview(dayIntLabel)

            dayLabel.snp.makeConstraints {
                $0.top.equalToSuperview().inset(11)
                $0.centerX.equalToSuperview()
            }

            dividerView.snp.makeConstraints {
                $0.top.equalToSuperview().inset(36)
                $0.width.equalToSuperview()
                $0.height.equalTo(0.7)
            }

            dayIntLabel.snp.makeConstraints {
                $0.top.equalToSuperview().inset(47)
                $0.centerX.equalToSuperview()
            }

            if day.isExist {
                let checkImageView = UIImageView()
                checkImageView.image = AkkinButton.checkButton

                dayView.addSubview(checkImageView)

                checkImageView.snp.makeConstraints {
                    $0.bottom.equalToSuperview().inset(10)
                    $0.centerX.equalToSuperview()
                    $0.width.height.equalTo(8)
                }
            }

            weekViewArray.append(dayView)

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))

            dayView.addGestureRecognizer(tapGesture)
            weekStackView.addArrangedSubview(dayView)
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        weekLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
        }

        previousButton.snp.makeConstraints {
            $0.trailing.equalTo(weekLabel.snp.leading).offset(-10)
            $0.centerY.equalTo(weekLabel.snp.centerY)
            $0.width.height.equalTo(8)
        }

        nextButton.snp.makeConstraints {
            $0.leading.equalTo(weekLabel.snp.trailing).offset(10)
            $0.centerY.equalTo(weekLabel.snp.centerY)
            $0.width.height.equalTo(8)
        }

        weekView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(62)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(82)
        }

        weekStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(62)
            $0.leading.trailing.equalTo(weekView).inset(14)
            $0.height.equalTo(82)
        }

        weeklyStatsCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(171)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview()
        }
    }

    // MARK: View Transition
    override func viewTransition() {
        backButton.tap = { [weak self] in
            guard let self else { return }
            router.dismissViewController()
        }
    }

    // MARK: Event
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        if let tappedView = sender.view {
            if let index = weekViewArray.firstIndex(of: tappedView) {
                print("Tapped view index: \(index)")
            }
        }
    }
}

extension WeeklyStatsViewController {
    // MARK: Networking
    private func getWeekly() {
        print("getWeekly")
        NetworkService.shared.weekly.getWeekly() { result in
            switch result {
            case .success(let response):
                guard let data = response as? WeeklyResponse else { return }
                self.weeklyEntries = data.entries
                print("hi")
                self.weekLabel.text = "\(data.month)월 \(data.weekOfMonth)주"
                print(data)
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
