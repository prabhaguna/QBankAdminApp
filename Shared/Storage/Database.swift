//
//  Database.swift
//  Admin (macOS)
//
//  Created by Saadhurya on 13/03/22.
//

import Foundation
import OHMySQL

typealias DatabaseItem = (QBankModel)

class Database : StorageAdapter {
    
    static let shared = Database()
    private init() {
        setup()
    }

    func setup() {
        let user = MySQLConfiguration(user: "qBankAdmin",
                                      password: "Prabhaguna2190",
                                      serverName: "127.0.0.1",
                                      dbName: "QBank",
                                      port: 3306, socket: nil)
        let coordinator = MySQLStoreCoordinator(configuration: user)
        coordinator.encoding = .UTF8MB4
        coordinator.connect()
        
        let context = MySQLQueryContext()
        context.storeCoordinator = coordinator
        MySQLContainer.shared.mainQueryContext = context
    }
    
    func insert<Item : DatabaseItem>(insertType : Item.Type,
                                     value : [String : Any],
                                     completion: @escaping ()->()) {
        let query = MySQLQueryRequestFactory.insert(Item.getTablename().rawValue,
                                                    set:value)
        try? MySQLContainer.shared.mainQueryContext?.execute(query)
        completion()
    }
    
    
    func loadItems<Item : DatabaseItem>(ofType ItemType : Item.Type, completion: @escaping ([Item]) -> ()) {
            
        let query = MySQLQueryRequestFactory.select(ItemType.getTablename().rawValue,
                                                    condition: nil)
            let response = ((try? MySQLContainer.shared.mainQueryContext?.executeQueryRequestAndFetchResult(query)) as [[String : Any]]??)
            guard let responseObject = response as? [[String : Any]] else {
                completion([])
                return
            }
            var tasks = [Item]()
            for taskResponse in responseObject {
                if let task = Item() as? NSObject {
                    task.map(fromResponse: taskResponse)
                    tasks.append(task as! Item)
                }
            }
            completion(tasks)
    }
    
    func update<Item : DatabaseItem>(ofType itemType : Item.Type,
                                     value : [String : Any],
                                     condition : String,
                                     completion: @escaping ()->()) {
        let query = MySQLQueryRequestFactory.update(itemType.getTablename().rawValue,
                                                    set:value,
                                                    condition: condition)
        try? MySQLContainer.shared.mainQueryContext?.execute(query)
        completion()
    }
    
    func delete<Item : DatabaseItem>(ofType itemType : Item.Type,
                                     condition : String,
                                     completion: @escaping ()->()) {
        let query = MySQLQueryRequestFactory.delete(itemType.getTablename().rawValue,
                                                    condition: condition)
        try? MySQLContainer.shared.mainQueryContext?.execute(query)
        completion()
    }
    
}
