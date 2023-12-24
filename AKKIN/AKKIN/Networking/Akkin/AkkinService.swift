//
//  AkkinService.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/25.
//

import Foundation
import Moya

final class AkkinService {
    private var akkinProvider = MoyaProvider<AkkinAPI>(plugins: [MoyaLoggerPlugin()])

    private enum ResponseData {
        case getAkkin
        case postAkkin
        case patchAkkin
        case deleteAkkin
    }

    public func getAkkin(completion: @escaping (NetworkResult<Any>) -> Void) {
        akkinProvider.request(.getAkkin) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getAkkin)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
                
            }
        }
    }

    public func postAkkin(year: Int, month: Int, day: Int, category: String, saveContent: String, how: String, expectCost: Int, realCost: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        akkinProvider.request(.postAkkin(year: year, month: month, day: day, category: category, saveContent: saveContent, how: how, expectCost: expectCost, realCost: realCost)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .postAkkin)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
                
            }
        }
    }

    public func patchAkkin(id: Int, year: Int, month: Int, day: Int, category: String, saveContent: String, how: String, expectCost: Int, realCost: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        akkinProvider.request(.patchAkkin(id: id, year: year, month: month, day: day, category: category, saveContent: saveContent, how: how, expectCost: expectCost, realCost: realCost)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .postAkkin)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
                
            }
        }
    }

    public func deleteAkkin(id: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        akkinProvider.request(.deleteAkkin(id: id)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .deleteAkkin)
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
            case .getAkkin, .postAkkin, .patchAkkin, .deleteAkkin:
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
        case .getAkkin:
            let decodedData = try? decoder.decode(AkkinEntireResponse.self, from: data)
            return .success(decodedData ?? "success")
        case .postAkkin, .patchAkkin, .deleteAkkin:
            let decodedData = try? decoder.decode(BlankDataResponse.self, from: data)
            return .success(decodedData ?? "success")
        }
    }
}
