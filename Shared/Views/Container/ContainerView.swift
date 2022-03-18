//
//  ContainerView.swift
//  Admin (macOS)
//
//  Created by Saadhurya on 13/03/22.
//

import SwiftUI

struct ContainerView: View {
    var body: some View {
        TabView {
            CategoriesView(viewModel: CategoriesViewModel())
                .tabItem {
                    Label("Category",
                          systemImage: "list.dash")
                }

            SubCategoriesView(viewModel: SubCategoriesViewModel())
                .tabItem {
                    Label("SubCategory", systemImage: "square.and.pencil")
                }
            ChallangeView()
                .tabItem {
                    Label("Challange", systemImage: "square.and.pencil")
                }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)

    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
}
