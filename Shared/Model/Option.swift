//
//  Option.swift
//  Admin (macOS)
//
//  Created by Saadhurya on 13/03/22.
//

import Foundation
import OHMySQL

final class Option : NSObject, QBankModel, MySQLMappingProtocol {
    @objc var id: NSNumber?
    @objc var value: String?
    @objc var challangeId: NSNumber?
    
    func mappingDictionary() -> [AnyHashable : Any]! {
        return ["id": "id",
                "value": "value",
                "challangeId": "challangeId"]
    }
    
    static func getTablename() -> QBankTable {
        return QBankTable.OPTIONS
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
