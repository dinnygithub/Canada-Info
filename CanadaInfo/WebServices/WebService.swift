//
//  WebService.swift
//  CanadaInfo
//
//  Created by Dinny Anand on 04/04/2020.
//  Copyright © 2020 Dinny Anand. All rights reserved.
//

import Foundation
import Alamofire

typealias JSONDictionary = [String: Any]

class WebService {
    func getApiData(url:String, callback: @escaping ((CanadaModel) -> ())){
        AF.request(url,method: .get).validate().response { response in
            switch response.result {
            case .success:
                guard let dataJson = response.data else { return }
                let responseStrInISOLatin = String(data: dataJson, encoding: String.Encoding.isoLatin1)
                guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                    debugPrint("could not convert data to UTF-8 format")
                    return
                }
                do {
                    guard let _ = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format, options: .mutableContainers) as? JSONDictionary else {return}
                    let decoder = JSONDecoder()
                    guard let canadaData = try? decoder.decode(CanadaModel.self, from: modifiedDataInUTF8Format) else { return }
                    DispatchQueue.main.async() {
                        callback(canadaData)
                    }
                }catch {
                    debugPrint(error)
                }
                break
            case .failure(let error):
                debugPrint(error)
                break
            }
        }
    }
}
