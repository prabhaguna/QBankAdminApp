//
//  SubCategoriesViewModel.swift
//  Admin (macOS)
//
//  Created by Saadhurya on 18/03/22.
//

import Foundation
import SwiftUI

class SubCategoriesViewModel : ObservableObject {
    @Published var categoryName : String? = ""

    @Published var editSCName : String?
    @Published var editNoOfhallanges : String?
    @Published var editMaxTime : String?
    @Published var editChallangeDate : String?

    @Published var selectedCategory : Categories?
    @Published var selectedSubCategory : SubCategories?

    @Published var arrCategories : [Categories]?
    @Published var arrSubCategories : [SubCategories]?

    init() {
        fetchCategory()
    }
    
    func fetchCategory() {
        resetEditView()
        Categories.fetch(completion: { [weak self] items in
            self?.arrCategories = items
            if let arrCategories = self?.arrCategories,
                   arrCategories.count > 0 {
                let categoryInfo = arrCategories[0]
                self?.categoryName = categoryInfo.name
                self?.selectCategory(category: categoryInfo)
                self?.fetchSubCategories(for: categoryInfo)
            }
        })
    }
    
    func selectCategory(category : Categories) {
        self.updateName(for: category)
        self.selectedCategory = category
    }

    func updateName(for category : Categories?) {
        if let category = category {
            self.categoryName = category.name
            fetchSubCategories(for: category)
        }
    }
    
    func fetchSubCategories(for category:Categories) {
        SubCategories.fetch(completion: { subCategories in
            self.arrSubCategories = subCategories
        }, condition: "categoryId=\(category.id ?? 0)")
    }
    
    func selectsubCategory(subCategory : SubCategories) {
        selectedSubCategory = subCategory
        editSCName = subCategory.name ?? ""
    }
    
    func saveSubCategory() {
        if let editSCName = editSCName,
           let editNoOfhallanges = editNoOfhallanges,
           let editMaxTime = editMaxTime,
           let editChallangeDate = editChallangeDate {
            
            let values : [String : Any] = [SubCategories.Keys.name.rawValue : editSCName,                       SubCategories.Keys.categoryId.rawValue : selectedCategory?.id as Any]
            
            
            if let selectedSubCategory = selectedSubCategory {
                selectedSubCategory.update(values: values,
                                    completion: { [weak self] in
                    self?.fetchSubCategories(for: (self?.selectedCategory!)!)
                })
            } else {
                SubCategories.create(values: values,
                              completion: { [weak self] in
                    self?.fetchSubCategories(for: (self?.selectedCategory!)!)
                })
            }
         }

    }
    
    func deleteSubCategory() {
        selectedSubCategory?.delete(completion: { [weak self] in
            self?.fetchSubCategories(for: (self?.selectedCategory!)!)
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
        arrCategories = testCategory
    }
   
}

extension SubCategoriesViewModel {
    
    func getEditBtnTitle() -> String {
        guard selectedSubCategory != nil else {
            return "Save"
        }
        return "Update"
    }
    
    func isShowDelete() -> Bool {
        guard selectedSubCategory != nil else {
            return false
        }
        return true
    }
    
    func itemBackGround(itemId : NSNumber?) -> Color {
        guard let updateItem = selectedSubCategory, itemId == updateItem.id else {
            return Color.black
        }
        return Color.red
    }
    
    func resetEditView() {
        self.selectedSubCategory = nil
    }
    
}
