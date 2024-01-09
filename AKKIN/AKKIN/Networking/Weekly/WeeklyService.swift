//
//  WeeklyService.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/25.
//

import Foundation
import Moya

final class WeeklyService {
    private var weeklyProvider = MoyaProvider<WeeklyAPI>(plugins: [MoyaLoggerPlugin()])

    private enum ResponseData {
        case getWeekly
    }

    public func getWeekly(completion: @escaping (NetworkResult<Any>) -> Void) {
        weeklyProvider.request(.getWeekly) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getWeekly)
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
            case .getWeekly:
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
        case .getWeekly:
            let decodedData = try? decoder.decode(WeeklyResponse.self, from: data)
            return .success(decodedData ?? "success")
        }
    }
}
