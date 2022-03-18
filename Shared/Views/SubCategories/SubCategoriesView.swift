//
//  SubCategoriesView.swift
//  Admin (macOS)
//
//  Created by Saadhurya on 13/03/22.
//

import SwiftUI

struct SubCategoriesView: View {
        
    @ObservedObject var viewModel : SubCategoriesViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.categoryName ?? "")
                .contextMenu {
                    if let categories = viewModel.arrCategories {
                     ForEach(categories) { category in
                            Button(category.name ?? "", action: {
                                viewModel.selectCategory(category: category)
                            }).background( viewModel.itemBackGround(itemId: category.id) )
                        }
                    }
                }
            
            VStack{
                HStack {
                    Text("SubCategory")
                    TextField("Sub CategoryVal",
                              text: $viewModel.editSCName ?? "")
                }
                HStack {
                    Text("NoOfChallanges")
                    TextField("NoOfChallanges",
                              text: $viewModel.editNoOfhallanges ?? "")
                }
                HStack {
                    Text("MaxTimeinSec")
                    TextField("MaxTimeinSec",
                              text: $viewModel.editMaxTime ?? "")
                }
                HStack {
                    Text("Date")
                    TextField("Chalange Date",
                              text: $viewModel.editChallangeDate ?? "")
                }

            }
            
            HStack {
                Button(viewModel.getEditBtnTitle() , action: {
                    viewModel.saveSubCategory()
                })
                
                if(viewModel.isShowDelete()) {
                    Button("Delete", action: {
                        viewModel.deleteSubCategory()
                    })
                }
                
                Button("Cancel", action: {
                    viewModel.resetEditView()
                })
            }
            
            Spacer()
            Text("Saved SubCategories").bold()

            if let subCategories = viewModel.arrSubCategories  {
                List(subCategories) { subCategory in
                    Button(subCategory.name ?? "", action: {
                        viewModel.selectsubCategory(subCategory: subCategory)
                    }).background( viewModel.itemBackGround(itemId: subCategory.id) )
                }
            }
        }
    }
}

struct SubCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SubCategoriesViewModel()
        viewModel.setTestCategories()
        return SubCategoriesView(viewModel: viewModel)
    }
}
