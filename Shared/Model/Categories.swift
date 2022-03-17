//
//  Categories.swift
//  Admin (macOS)
//
//  Created by Saadhurya on 13/03/22.
//

import Foundation
import OHMySQL
import SwiftUI

enum QBankTable : String {
    case CATEGORIES = "CATEGORIES",
    SUBCATEGORIES = "SUBCATEGORIES",
    CHALLANGES = "CHALLANGES",
    OPTIONS = "OPTIONS"

}

final class Categories : (NSObject & QBankModel & MySQLMappingProtocol) {
    @objc var id: NSNumber?
    @objc var name: String?
    
    enum Keys : String {
        case id, name
    }
    
    func mappingDictionary() -> [AnyHashable : Any]! {
        return ["id": "id",
                "name": "name"]
    }
    
    static func getTablename() -> QBankTable {
        return QBankTable.CATEGORIES
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
