//
//  AppleLoginService.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/24.
//

import Foundation
import Moya

final class AppleLoginService {
    
    private var appleLoginProvider = MoyaProvider<AppleLoginAPI>(plugins: [MoyaLoggerPlugin()])
    
    private enum ResponseData {
        case postAppleLogin
    }
    
    public func postAppleLogin(appleToken: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        appleLoginProvider.request(.postAppleLogin(appleToken: appleToken)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .postAppleLogin)
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
            case .postAppleLogin:
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
        case .postAppleLogin:
            let decodedData = try? decoder.decode(BlankDataResponse.self, from: data)
            return .success(decodedData ?? "success")
        }
    }
}
