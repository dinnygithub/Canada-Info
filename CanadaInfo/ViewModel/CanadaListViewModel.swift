//
//  CanadaListViewModel.swift
//  CanadaInfo
//
//  Created by Dinny Anand on 04/04/2020.
//  Copyright © 2020 Dinny Anand. All rights reserved.
//

import Foundation
typealias CompletionHandler =  ((CanadaModel) -> ())
class CanadaListViewModel {
    var title :String?
    var canadaRows :[Row]?
    init(){
        title = nil
        canadaRows = nil
    }
    init(title: String,  rows :[Row]?) {
        self.title = title
        self.canadaRows = rows
    }
    var dataCanada = CanadaModel()
}

extension CanadaListViewModel {
    func getCanadaData(completion: @escaping CompletionHandler){
        WebService().getApiData(url: kBaseUrl){  canadaData in
            self.dataCanada = canadaData
            completion(self.dataCanada)
        }
    }
}
