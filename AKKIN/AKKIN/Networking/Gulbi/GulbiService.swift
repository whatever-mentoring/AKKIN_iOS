//
//  AkkinService.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/25.
//

import Foundation
import Moya

final class GulbiService {
    private var gulbiProvider = MoyaProvider<GulbiAPI>(plugins: [MoyaLoggerPlugin()])

    private enum ResponseData {
        case getGulbis
        case postGulbis
        case patchGulbis
        case deleteGulbis
    }

    public func getGulbis(completion: @escaping (NetworkResult<Any>) -> Void) {
        gulbiProvider.request(.getGulbis) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
      
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getGulbis)
                completion(networkResult)

            case .failure(let error):
                print(error)
            }
        }
    }

    public func postGulbis(
        year: Int,
        month: Int,
        day: Int,
        imageUrl: String,
        category: String,
        saveContent: String,
        how: String,
        expectCost: Int,
        realCost: Int,
        completion: @escaping (NetworkResult<Any>) -> Void
    ) {
        gulbiProvider.request(.postGulbis(
            year: year,
            month: month,
            day: day,
            imageUrl: imageUrl,
            category: category,
            saveContent: saveContent,
            how: how,
            expectCost: expectCost,
            realCost: realCost
        )) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(
                    by: statusCode, data,
                    responseData: .postGulbis)
                completion(networkResult)

            case .failure(let error):
                print(error)
            }
        }
    }

    public func patchGulbis(
        id: Int,
        year: Int,
        month: Int,
        day: Int,
        imageUrl: String,
        category: String,
        saveContent: String,
        how: String,
        expectCost: Int,
        realCost: Int,
        completion: @escaping (NetworkResult<Any>) -> Void
    ) {
        gulbiProvider.request(.patchGulbis(
            id: id,
            year: year,
            month: month,
            day: day,
            imageUrl: imageUrl,
            category: category,
            saveContent: saveContent,
            how: how,
            expectCost: expectCost,
            realCost: realCost
        )) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(
                    by: statusCode, data,
                    responseData: .patchGulbis)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
                
            }
        }
    }

    public func deleteGulbis(id: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        gulbiProvider.request(.deleteGulbis(id: id)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(
                    by: statusCode, data,
                    responseData: .deleteGulbis)
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
            case .getGulbis, .postGulbis, .patchGulbis, .deleteGulbis:
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
        case .getGulbis:
            let decodedData = try? decoder.decode(AkkinEntireResponse.self, from: data)
            return .success(decodedData ?? "success")
        case .postGulbis, .patchGulbis, .deleteGulbis:
            let decodedData = try? decoder.decode(BlankDataResponse.self, from: data)
            return .success(decodedData ?? "success")
        }
    }
}
