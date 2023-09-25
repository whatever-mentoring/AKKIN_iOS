//
//  MainService.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/25.
//

import Foundation
import Moya

final class MainService {
    private var mainProvider = MoyaProvider<MainAPI>(plugins: [MoyaLoggerPlugin()])
    
    private enum ResponseData {
        case getMain
    }
    
    public func getMain(completion: @escaping (NetworkResult<Any>) -> Void) {
        mainProvider.request(.getMain) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getMain)
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
            case .getMain:
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
        case .getMain:
            let decodedData = try? decoder.decode(MainResponse.self, from: data)
            return .success(decodedData ?? "success")
        }
    }
}

//사용 방법 - 사용할 곳에서 구현 후 호출
//private func getMain() {
//    print("getMain")
//    NetworkService.shared.main.getMain() { result in
//        switch result {
//        case .success(let response):
//            guard let data = response as? MainResponse else { return }
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
