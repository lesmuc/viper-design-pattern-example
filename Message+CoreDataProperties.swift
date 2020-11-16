//
//  Message+CoreDataProperties.swift
//  viper42
//
//  Created by Udo von Eynern on 06.12.18.
//  Copyright © 2018 Udo von Eynern. All rights reserved.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var objectId: Int32
    @NSManaged public var createdAt: NSDate?
    @NSManaged public var updatedAt: NSDate?
    @NSManaged public var title: String?
    @NSManaged public var userId: Int32
    @NSManaged public var questionId: Int32
    @NSManaged public var imagePath: String?

}
