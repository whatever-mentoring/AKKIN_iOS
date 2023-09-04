//
//  RequestProvider.swift
//  AKKIN
//
//  Created by MK-Mac-413 on 2023/09/04.
//

import Moya

typealias ExampleProvider = RequestProvider<ExampleAPI>

final class RequestProvider<Target: TargetType>: MoyaProvider<Target> {

    // MARK: Initializer
    init(session: Session) {
        super.init(session: session, plugins: [])
    }
}

