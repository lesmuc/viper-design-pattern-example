//
//  Endpoints.swift
//  viper42
//
//  Created by Udo von Eynern on 05.12.18.
//  Copyright © 2018 Udo von Eynern. All rights reserved.
//

import Foundation

struct API {
    static let baseUrl = "https://www.frag42.de"
    static let googleBaseUrl = "http://maps.googleapis.com"
    
    static func ImageURL(filename: String, width: Int, height: Int) -> String {
        return "\(API.baseUrl)/image.php?src=uploads/question/\(filename)&w=\(width)&h=\(height)"
    }
    
    static func GoogleMapsURL(latitude: Double, longitude: Double, width: Int, height: Int) -> String {
        return "\(API.googleBaseUrl)/maps/api/staticmap?center=\(latitude),\(longitude)&zoom=14&size=\(width)x\(height)&sensor=true"
    }
}

protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Endpoints {
    
    enum Questions: Endpoint {
        case fetchFresh
        
            public var path: String {
                switch self {
                case .fetchFresh: return "/question/fresh"
                }
            }
        
            public var url: String {
                switch self {
                case .fetchFresh: return "\(API.baseUrl)\(path)"
                }
            }
    }
}
