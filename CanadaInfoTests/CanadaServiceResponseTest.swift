//
//  CanadaDataSourceTest.swift
//  CanadaInfoTests
//
//  Created by Dinny Anand on 05/04/2020.
//  Copyright © 2020 Dinny Anand. All rights reserved.
//

import XCTest
import Alamofire
@testable import CanadaInfo

class CanadaServiceResponseTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testIfValidRows(){
        var responseStr: String?
        AF.request(kBaseUrl,method: .get).response { response in
            guard let dataJson = response.data else { return }
            let responseStrInISOLatin = String(data: dataJson, encoding: String.Encoding.isoLatin1)
            guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                debugPrint("could not convert data to UTF-8 format")
                return
            }
            do {
                responseStr =  try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format, options: .mutableContainers) as? String
                let expectation = self.expectation(description: "NoRows")
                expectation.fulfill()
                
            }catch {
                debugPrint(error)
            }
            self.waitForExpectations(timeout: 5, handler: nil)
            XCTAssertTrue(responseStr!.contains("rows"))
        }
    }
    
    func testIfValidTitle(){
        var responseStr: String?
        AF.request(kBaseUrl,method: .get).response { response in
            guard let dataJson = response.data else { return }
            let responseStrInISOLatin = String(data: dataJson, encoding: String.Encoding.isoLatin1)
            guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                debugPrint("could not convert data to UTF-8 format")
                return
            }
            do {
                responseStr =  try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format, options: .mutableContainers) as? String
                let expectation = self.expectation(description: "NoTitle")
                expectation.fulfill()
                
            }catch {
                debugPrint(error)
            }
            self.waitForExpectations(timeout: 5, handler: nil)
            XCTAssertTrue(responseStr!.contains("title"))
        }
        
    }
    
}
