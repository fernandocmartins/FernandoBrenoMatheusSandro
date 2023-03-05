//
//  ProductData+CoreDataProperties.swift
//  TCC
//
//  Created by Fernando Cesar Martins on 17/02/23.
//
//

import Foundation
import CoreData


extension ProductData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductData> {
        return NSFetchRequest<ProductData>(entityName: "ProductData")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var card: Bool
    @NSManaged public var photo: Data?
    @NSManaged public var state: StateData?

}

extension ProductData : Identifiable {

}
