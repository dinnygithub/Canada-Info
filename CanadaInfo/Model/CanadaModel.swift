//
//  CanadaModel.swift
//  CanadaInfo
//
//  Created by Dinny Anand on 01/04/2020.
//  Copyright © 2020 Dinny Anand. All rights reserved.
//

import Foundation

struct CanadaModel : Codable {
    var title : String
    var rows : [Row]?
    private enum CodingKeys : String, CodingKey {
        case title
        case rows
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = ""
        if let value = try? container.decode(String.self, forKey: .title){
            title = value
        }
        
        rows = [Row]()
        if let value = try? container.decode([Row].self, forKey: .rows){
            rows = value
        }
    }
}

struct Row : Codable {
    var title : String
    var description : String
    var imageHref : String
    private enum CodingKeys : String, CodingKey {
        case title
        case description
        case imageHref
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = ""
        if let value = try? container.decode(String.self, forKey: .title){
            title = value
        }
        description = ""
        if let value = try? container.decode(String.self, forKey: .description){
            description = value
        }
        imageHref = ""
        if let value = try? container.decode(String.self, forKey: .imageHref){
            imageHref = value
        }
    }
    init(){
        title = ""
        description = ""
        imageHref = ""
    }
    
}
