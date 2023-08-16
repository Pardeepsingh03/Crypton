//
//  SearchBarView.swift
//  Crypton
//
//  Created by MBA-0019 on 20/06/23.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var serachText : String
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(serachText.isEmpty ? Color.theme.secondaryTextColor : Color.theme.accentColor)
          
                TextField("Search by name or symbol...", text: $serachText)
                .foregroundColor(Color.theme.accentColor)
                .disableAutocorrection(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .opacity(serachText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                        serachText = ""
                    }
                        .foregroundColor(Color.theme.accentColor)
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.theme.backGroundColor)
                .shadow(color: Color.theme.accentColor.opacity(0.25), radius: 10 , x: 0,y: 0)
        )
        .padding()
    }
    
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            SearchBarView(serachText: .constant(""))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
            
            SearchBarView(serachText: .constant(""))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
       
    }
}
