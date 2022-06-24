//
//  CommentView.swift
//  IOS_FINAL
//
//  Created by Alvin on 2022/6/24.
//

import Foundation
import SwiftUI

struct CommentView: View {
    let comment: Comment
    
    var body: some View {
        HStack {
            VStack {
                Image("notes1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                
                Text(comment.userName)
            }
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    ForEach(0..<comment.rate, id:\.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                }
                
                Text(comment.description)
            }
            Spacer()
            Text(comment.date)
                .padding(.bottom)
        }
        .padding(.horizontal)
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(comment: Comment(date: "2022-02-29", description: "A little bit update", rate: 4, userName: "Mary"))
    }
}
