//
//  CategoryView.swift
//  IOS_FINAL
//
//  Created by lo pui yi on 24/6/2022.
//

import SwiftUI

struct CategoryView: View {
    let category: String
    

    var body: some View {
        VStack {
            Image(category)
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .clipShape(Circle())
                .shadow(radius: 10)
                .overlay(Circle().stroke(Color.blue, lineWidth: 3))
            
            Text(category)
                .foregroundColor(Color.gray)
            
            Spacer()
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: "ALL")
            .previewLayout(.sizeThatFits)
    }
}
