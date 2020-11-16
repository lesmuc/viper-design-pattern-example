//
//  QuestionListModel.swift
//  viper42
//
//  Created by Udo von Eynern on 08.12.18.
//  Copyright © 2018 Udo von Eynern. All rights reserved.
//

import Foundation

struct QuestionListStruct: Decodable {
    
    var questions:[Question]

    private enum CodingKeys: String, CodingKey {
        case response = "response"
        case items = "items"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let response = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        questions = try response.decode([Question].self, forKey: .items)
    }
    
}
