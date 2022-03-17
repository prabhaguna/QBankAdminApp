//
//  CategoriesViewModel.swift
//  Admin (macOS)
//
//  Created by Saadhurya on 13/03/22.
//

import Foundation
import SwiftUI

class CategoriesViewModel : ObservableObject {
    @Published var editVal: String?
    @Published var selectedCategory : Categories?
    @Published var items : [Categories]?

    init() {
        fetchCategory()
    }
    
    func fetchCategory() {
        resetEditView()
        Categories.fetch(completion: { items in
            self.items = items
        })
    }
    
    func selectCategory(category : Categories) {
        self.selectedCategory = category
        editVal = category.name ?? ""
    }
    
    func saveCategory() {
        if let editVal = editVal {
            if let selectedCategory = selectedCategory {
                selectedCategory.update(values: [Categories.Keys.name.rawValue : editVal],
                                    completion: {items in
                    self.items = items
                })
            } else {
                Categories.create(values: [Categories.Keys.name.rawValue : editVal],
                              completion: {items in
                    self.items = items
                })
            }
         }
    }
    
    func deleteCategory() {
        selectedCategory?.delete(completion: { items in
            self.items = items
        })
    }
    
    func setTestCategories() {
        var testCategory : [Categories] = [Categories]()
        let category1 = Categories()
        category1.id = 1
        category1.name = "Test"
        testCategory.append(category1)
        
        let category2 = Categories()
        category2.id = 1
        category2.name = "Test"
        testCategory.append(category2)
        
        let category3 = Categories()
        category3.id = 1
        category3.name = "Test"
        testCategory.append(category3)
        
        let category4 = Categories()
        category4.id = 1
        category4.name = "Test"
        testCategory.append(category4)
        
        let category5 = Categories()
        category5.id = 1
        category5.name = "Test"
        testCategory.append(category5)
        items = testCategory
    }
   
}

extension CategoriesViewModel {
    
    func getEditBtnTitle() -> String {
        guard selectedCategory != nil else {
            return "Save"
        }
        return "Update"
    }
    
    func isShowDelete() -> Bool {
        guard selectedCategory != nil else {
            return false
        }
        return true
    }
    
    func itemBackGround(itemId : NSNumber?) -> Color {
        guard let updateItem = selectedCategory, itemId == updateItem.id else {
            return Color.black
        }
        return Color.red
    }
    
    func resetEditView() {
        self.selectedCategory = nil
    }
    
}
