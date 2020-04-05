//
//  CanadaViewModelTests.swift
//  CanadaInfoTests
//
//  Created by Dinny Anand on 05/04/2020.
//  Copyright © 2020 Dinny Anand. All rights reserved.
//

import XCTest
@testable import CanadaInfo

class CanadaViewModelTests: XCTestCase {
    private var viewModel: CanadaListViewModel = CanadaListViewModel()
    
    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: classForCoder)
        let url = bundle.url(forResource: "canady", withExtension: "json")
        // Load Stub
        let data = try! Data(contentsOf: url!)
        let decoder = JSONDecoder()
        guard let canadaData = try? decoder.decode(CanadaModel.self, from: data) else { return }
        self.viewModel = CanadaListViewModel(title: canadaData.title,  rows: canadaData.rows)
    }
    func testRows() {
        let row = self.viewModel.canadaRows
        XCTAssertTrue(row?.count ?? 0>0, "Rows more than 0")
    }
    func testTitle(){
        let title = self.viewModel.title
        XCTAssertTrue(title?.count ?? 0 > 0, "Title")
    }
}
