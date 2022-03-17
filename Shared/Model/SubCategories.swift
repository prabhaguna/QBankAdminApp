//
//  SubCategories.swift
//  Admin (macOS)
//
//  Created by Saadhurya on 13/03/22.
//

import Foundation
import OHMySQL

final class SubCategories : NSObject, QBankModel, MySQLMappingProtocol {
    @objc var id: NSNumber?
    @objc var name: String?
    @objc var categoryId: NSNumber?
    @objc var date: Date?
    
    func mappingDictionary() -> [AnyHashable : Any]! {
        return ["id": "id",
                "name": "name",
                "categoryId": "categoryId",
                "date": "date"]
    }
    
    static func getTablename() -> QBankTable {
        return QBankTable.SUBCATEGORIES
    }
    
    func mySQLTable() -> String! {
        return Categories.getTablename().rawValue
    }
    
    func primaryKey() -> String! {
        return "id"
    }

    func getUpdateValues() -> [String : Any]? {
        return [:]
    }
}
