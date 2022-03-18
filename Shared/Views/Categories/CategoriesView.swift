//
//  CategoriesView.swift
//  Admin (macOS)
//
//  Created by Saadhurya on 13/03/22.
//

import SwiftUI

struct CategoriesView: View {
    @ObservedObject var viewModel: CategoriesViewModel

    var body: some View {
        VStack {
            
            VStack {
                HStack {
                    Text("Category")
                    TextField("categoryVal",
                              text: $viewModel.editVal ?? "")
                }
                
                
                HStack {
                    Button(viewModel.getEditBtnTitle() , action: {
                        viewModel.saveCategory()
                    })
                    
                    if(viewModel.isShowDelete()) {
                        Button("Delete", action: {
                            viewModel.deleteCategory()
                        })
                    }
                    
                    Button("Cancel", action: {
                        viewModel.resetEditView()
                    })
                }
               
            }.frame(height: 100,
                    alignment: .top)
            
            Spacer()
            Text("Saved Categories").bold()
            if let categories = viewModel.items  {
                List(categories) { category in
                    Button(category.name ?? "", action: {
                        viewModel.selectCategory(category: category)
                    }).background( viewModel.itemBackGround(itemId: category.id) )
                }
            }
          
        }

    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CategoriesViewModel()
        viewModel.setTestCategories()
       return CategoriesView(viewModel: viewModel)
    }
}
