//
//  CanadaModelTest.swift
//  CanadaInfoTests
//
//  Created by Dinny Anand on 02/04/2020.
//  Copyright © 2020 Dinny Anand. All rights reserved.
//

import XCTest
@testable import CanadaInfo

class CanadaModelTest: XCTestCase {
    
     var canadaList : [Row] = []
    var viewTitle : String?
    
    override func setUp() {
        super.setUp()

        let bundle = Bundle(for: classForCoder)
        let url = bundle.url(forResource: "canady", withExtension: "json")
        
        // Load Stub
        let data = try! Data(contentsOf: url!)
        let decoder = JSONDecoder()
        guard let articlesData = try? decoder.decode(CanadaModel.self, from: data) else { return }
        canadaList = articlesData.rows!
        viewTitle = articlesData.title
    }
    func testTitle() {
        let row = canadaList.first
        XCTAssertEqual(row?.title,"Beavers")
    }
    func testMediaUrl(){
         let row = canadaList.first
        XCTAssertEqual(row?.imageHref, "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg")
    }
    func testViewTitle() {
        XCTAssertEqual(viewTitle,"About Canada")
    }
}
