//
//  NetworkService.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/24.
//

final class NetworkService {
    static let shared = NetworkService()
    
    private init() { }
    
    let appleLogin = AuthService()
    let main = MainService()
    let weekly = WeeklyService()
    let monthly = MonthlyService()
    let akkin = AkkinService()

}
