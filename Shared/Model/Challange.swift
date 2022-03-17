//
//  Challange.swift
//  Admin (macOS)
//
//  Created by Saadhurya on 13/03/22.
//

import Foundation
import OHMySQL

final class Challange : NSObject, QBankModel, MySQLMappingProtocol {
    @objc var id: NSNumber?
    @objc var challange: String?
    @objc var subcategoryId: NSNumber?
    
    func mappingDictionary() -> [AnyHashable : Any]! {
        return ["id": "id",
                "challange": "challange",
                "subcategoryId": "subcategoryId"]
    }
    
    static func getTablename() -> QBankTable {
        return QBankTable.CHALLANGES
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

