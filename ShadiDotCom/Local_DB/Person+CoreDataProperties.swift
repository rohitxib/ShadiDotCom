//
//  Person+CoreDataProperties.swift
//  ShadiDotCom
//
//  Created by Rohit on 16/01/25.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var cell: String?
    @NSManaged public var dob: NSObject?
    @NSManaged public var email: String?
    @NSManaged public var gender: String?
    @NSManaged public var id: NSObject?
    @NSManaged public var location: NSObject?
    @NSManaged public var login: NSObject?
    @NSManaged public var name: NSObject?
    @NSManaged public var nat: String?
    @NSManaged public var phone: String?
    @NSManaged public var picture: NSObject?
    @NSManaged public var registered: NSObject?
    @NSManaged public var aceptedOrRejected: String?


}

extension Person : Identifiable {

}
