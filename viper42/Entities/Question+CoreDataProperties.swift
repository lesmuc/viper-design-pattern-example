//
//  Question+CoreDataProperties.swift
//  
//
//  Created by Udo von Eynern on 06.12.18.
//
//

import Foundation
import CoreData


extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
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
    @NSManaged public var imagePath: String?

}
