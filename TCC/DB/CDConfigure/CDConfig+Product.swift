//
//  CDConfig+Product.swift
//  TCC
//
//  Created by Fernando Cesar Martins on 24/02/23.
//

extension CDConfig {
    
    
    func updateItem (with data: ProductData, newData: Product) {
        guard let context = getContext() else { return }
        data.price = newData.price
        data.state = newData.state
        data.name = newData.name
        data.card = newData.card
        data.photo = newData.image.pngData()
        do {
            try context.save()
        }
        catch {
            print("erro update item")
        }
    }
    
    internal func deleteProduct(data: ProductData) {
        guard let context = getContext() else { return }
        context.delete(data)
        do {
            try context.save()
        }
        catch {
            print("erro delete item")
        }
    }

    internal func saveProduct(data: Product) {
        guard let context = getContext() else { return }
        let newItem = ProductData(context: context)
        newItem.price = data.price
        newItem.state = data.state
        newItem.name  = data.name
        newItem.card  = data.card
        newItem.photo = data.image.pngData()
        do {
            try context.save()
        }
        catch {
            print("erro save item")
        }
    }
}
