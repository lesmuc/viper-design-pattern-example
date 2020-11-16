//
//  Question+CoreDataClass.swift
//  viper42
//
//  Created by Udo von Eynern on 06.12.18.
//  Copyright © 2018 Udo von Eynern. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Question)
public class Question: NSManagedObject, Codable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: String(describing: self))
    }
    
    @NSManaged public var objectId: Int32
    @NSManaged public var createdAt: NSDate?
    @NSManaged public var updatedAt: NSDate?
    @NSManaged public var title: String?
    @NSManaged public var userId: Int32
    @NSManaged public var address: String?
    @NSManaged public var postalCode: String?
    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var distance: Double
    @NSManaged public var imagePath: String?
    
    enum CodingKeys: String, CodingKey {
        case objectId
        case createdAt
        case updatedAt
        case title
        case userId
        case address
        case postalCode
        case city
        case country
        case latitude
        case longitude
        case distance
        case imagePath
    }
    
    required convenience public init(from decoder: Decoder) throws {
        
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Question", in: managedObjectContext) else {
                fatalError("Failed to decode Question")
        }

        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let objectIdString = try container.decode(String.self, forKey: .objectId)
        self.objectId = Int32(objectIdString) ?? 0
        
        if let createdAtDate = try container.decodeIfPresent(Date.self, forKey: .createdAt) {
            self.createdAt = createdAtDate as NSDate
        }
        
        if let updatedAtDate = try container.decodeIfPresent(Date.self, forKey: .updatedAt) {
            self.updatedAt = updatedAtDate as NSDate
        }
        
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        
        let userIdString = try container.decode(String.self, forKey: .userId)
        self.userId = Int32(userIdString) ?? 0
        
        self.address = try container.decodeIfPresent(String.self, forKey: .address)
        self.postalCode = try container.decodeIfPresent(String.self, forKey: .postalCode)
        self.city = try container.decodeIfPresent(String.self, forKey: .city)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.latitude = try container.decodeIfPresent(Double.self, forKey: .latitude) ?? 0.0
        self.longitude = try container.decodeIfPresent(Double.self, forKey: .longitude) ?? 0.0
        self.distance = try container.decodeIfPresent(Double.self, forKey: .distance) ?? 0.0
        self.imagePath = try container.decodeIfPresent(String.self, forKey: .imagePath)
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }

}
