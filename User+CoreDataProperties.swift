//
//  User+CoreDataProperties.swift
//  viper42
//
//  Created by Udo von Eynern on 06.12.18.
//  Copyright © 2018 Udo von Eynern. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var objectId: Int32
    @NSManaged public var createdAt: NSDate?
    @NSManaged public var updatedAt: NSDate?
    @NSManaged public var email: String?
    @NSManaged public var username: String?
    @NSManaged public var password: String?
    @NSManaged public var facebookId: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var gender: String?
    @NSManaged public var imagePath: String?
    @NSManaged public var deviceToken: String?
    @NSManaged public var lang: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var locationService: String?

}
