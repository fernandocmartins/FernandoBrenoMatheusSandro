//
//  CDConfig.swift
//  TCC
//
//  Created by Fernando Cesar Martins on 23/02/23.
//

import UIKit
import CoreData

final class CDConfig: NSObject {
    
    static let shared = CDConfig()
    
    internal func getContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    func saveItem(with data: Any) {
        switch data {
        case let tax as State:
            saveState(data: tax)
        case let product as Product:
            saveProduct(data: product)
        default:
            break;
        }
    }
    
    func deleteItem(with data: Any) {
        switch data {
        case let tax as StateData:
            deleteState(data: tax)
        case let product as ProductData:
            deleteProduct(data: product)
        default:
            break;
        }
    }
    
    func getAllItems<T: NSManagedObject>(with fetchRequest: NSFetchRequest<T>) -> [NSManagedObject]? {
        do {
            let items = try getContext()?.fetch(fetchRequest)
            return items
        }
        catch {
            print("erro get all item")
            return nil
        }
    }

}
