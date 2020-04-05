//
//  CanadaListViewModel.swift
//  CanadaInfo
//
//  Created by Dinny Anand on 04/04/2020.
//  Copyright © 2020 Dinny Anand. All rights reserved.
//

import Foundation
struct CanadaListViewModel {
    var title :String?
    var canadaRows :[Row]?
    init(){
        title = nil
        canadaRows = nil
    }
}

extension CanadaListViewModel {
    init(title: String,  rows :[Row]?) {
        self.title = title
        self.canadaRows = rows
    }
}
