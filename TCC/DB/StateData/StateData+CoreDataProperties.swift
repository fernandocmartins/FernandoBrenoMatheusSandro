//
//  StateData+CoreDataProperties.swift
//  TCC
//
//  Created by Fernando Cesar Martins on 17/02/23.
//
//

import Foundation
import CoreData


extension StateData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StateData> {
        return NSFetchRequest<StateData>(entityName: "StateData")
    }

    @NSManaged public var name: String?
    @NSManaged public var tax: String?

}

extension StateData : Identifiable {

}
