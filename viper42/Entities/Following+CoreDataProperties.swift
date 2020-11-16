//
//  Following+CoreDataProperties.swift
//  
//
//  Created by Udo von Eynern on 06.12.18.
//
//

import Foundation
import CoreData


extension Following {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Following> {
        return NSFetchRequest<Following>(entityName: "Following")
    }

    @NSManaged public var objectId: Int32
    @NSManaged public var userId: Int32
    @NSManaged public var questionId: Int32

}
