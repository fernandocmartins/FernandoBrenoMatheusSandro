//
//  CDConfig+State.swift
//  TCC
//
//  Created by Fernando Cesar Martins on 24/02/23.
//

extension CDConfig {
    internal func saveState(data: State) {
        guard let context = getContext() else { return }
        let newItem = StateData(context: context)
        newItem.tax = data.tax
        newItem.name = data.name
        do {
            try context.save()
        }
        catch {
            print("erro save item")
        }
    }
    
    internal func deleteState(data: StateData) {
        guard let context = getContext() else { return }
        context.delete(data)
        do {
            try context.save()
        }
        catch {
            print("erro delete item")
        }
    }
}
