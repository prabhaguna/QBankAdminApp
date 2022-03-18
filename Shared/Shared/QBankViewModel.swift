//
//  QBankViewModel.swift
//  Admin (iOS)
//
//  Created by Saadhurya on 16/03/22.
//

import Foundation


protocol QBankModel : Identifiable {
    var id: NSNumber? {get set}
    init()
    static func getTablename() -> QBankTable
    func getUpdateValues() -> [String : Any]?
}


extension QBankModel {

    typealias Items = ([Self]?) -> ()
    typealias ActionCompletion = () -> ()
   
    static func create(values: [String : Any] ,
                       completion: @escaping  ActionCompletion) {
       
        let insertVal : [String : Any] = values
        Database.shared.insert(insertType: Self.self,
                               value: insertVal,
                               completion: {
            completion()
        })
    }
    
    static func fetch(completion : @escaping Items, condition : String? = nil) {
        Database.shared.loadItems(ofType: Self.self , completion: { items in
            completion(items)
        }, condition: condition)
    }
       
    func update(values: [String : Any], completion : @escaping  ActionCompletion) {
        
        if let id = id {
           let updateVal : [String : Any] = values
           Database.shared.update(ofType: type(of: self),
                                   value: updateVal,
                                   condition: "id=\(id)",
                                   completion: {
               completion()
           })
        }
    }

    func delete(completion : @escaping  ActionCompletion) {
        if  let id = id {
            Database.shared.delete(ofType: type(of: self),
                                   condition: "id=\(id)",
                                   completion: {  
                completion()
            })
        }
    }
   
}
