//
//  Connectivity.swift
//  CanadaInfo
//
//  Created by Dinny Anand on 04/04/2020.
//  Copyright © 2020 Dinny Anand. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
