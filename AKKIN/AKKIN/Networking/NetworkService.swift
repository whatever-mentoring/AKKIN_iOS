//
//  NetworkService.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/24.
//

final class NetworkService {
    static let shared = NetworkService()
    
    private init() { }
    
    let auth = AuthService()
    let main = MainService()
    let gulbis = GulbiService()
    let weekly = WeeklyService()
    let monthly = MonthlyService()
}
