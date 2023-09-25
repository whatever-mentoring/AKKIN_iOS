//
//  MonthlyService.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/25.
//

import Foundation
import Moya

final class MonthlyService {
    private var wonthlyProvider = MoyaProvider<MonthlyAPI>(plugins: [MoyaLoggerPlugin()])

    private enum ResponseData {
        case getMonthly
    }

    public func getMonthly(completion: @escaping (NetworkResult<Any>) -> Void) {
        wonthlyProvider.request(.getMonthly) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getMonthly)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
                
            }
        }
    }

    private func judgeStatus(by statusCode: Int, _ data: Data, responseData: ResponseData) -> NetworkResult<Any> {
        let decoder = JSONDecoder()

        switch statusCode {
        case 200..<300:
            switch responseData {
            case .getMonthly:
                return isValidData(data: data, responseData: responseData)
            }
        case 400..<500:
            guard let decodedData = try? decoder.decode(ErrorResponse.self, from: data) else {
                return .pathErr
            }
            return .requestErr(decodedData)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }

    private func isValidData(data: Data, responseData: ResponseData) -> NetworkResult<Any> {
        let decoder = JSONDecoder()

        switch responseData {
        case .getMonthly:
            let decodedData = try? decoder.decode(MonthlyResponse.self, from: data)
            return .success(decodedData ?? "success")
        }
    }
}

//사용 방법 - 사용할 곳에서 구현 후 호출
//private func getMonthly() {
//    print("getMonthly")
//    NetworkService.shared.monthly.getMonthly() { result in
//        switch result {
//        case .success(let response):
//            guard let data = response as? MonthlyResponse else { return }
//            print(data)
//        case .requestErr(let errorResponse):
//            dump(errorResponse)
//            guard let data = errorResponse as? ErrorResponse else { return }
//            print(data)
//        case .serverErr:
//            print("serverErr")
//        case .networkFail:
//            print("networkFail")
//        case .pathErr:
//            print("pathErr")
//        }
//    }
//}
