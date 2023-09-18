//
//  WeeklyStatsViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/16.
//
import UIKit

enum WEEK: CaseIterable {
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
}

final class WeeklyStatsViewController: BaseViewController {

    // MARK: UI Components
    private let weekLabel = UILabel().then {
        $0.text = "9월 둘째주"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }

    private let previousButton = BaseButton().then {
        $0.setImage(UIImage(named: "previousButton"), for: .normal)
    }

    private let nextButton = BaseButton().then {
        $0.setImage(UIImage(named: "detailButton"), for: .normal)
    }

    private let backButton = BaseButton().then {
        $0.setImage(UIImage(named: "backButton"), for: .normal)
    }

    private let weekView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
    }

    private let weekStackView = UIStackView().then {
        $0.backgroundColor = .brown
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }

    private let dayView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.red.cgColor
    }

    private let dayStringLabel = UILabel().then {
        $0.text = "SUN"
        $0.font = .systemFont(ofSize: 10)
    }

    private let dividerView = UIView().then {
        $0.backgroundColor = .black
    }

    private let dayIntLabel = UILabel().then {
        $0.text = "3"
        $0.font = .systemFont(ofSize: 10)
    }

    private let checkImageView = UIImageView().then {
        $0.image = UIImage(named: "checkButton")
    }

    // MARK: Environment
    private let router = ExampleRouter()
    private let weeklyStatsCollectionView = WeeklyStatsCollectionView()

    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.99, alpha: 1)

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
        // 달력
        view.addSubview(weekView)
        // 컬렉션 뷰
        view.addSubview(weeklyStatsCollectionView)

        weekView.addSubview(weekStackView)

        let dayViews = WEEK.allCases.map { week in
            let dayVieww = UIView().then {
                $0.backgroundColor = .white
            }

            return dayVieww
        }

        for dayView in dayViews {
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

        dayStringLabel.snp.makeConstraints {
            $0.width.height.equalTo(20)
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
}
