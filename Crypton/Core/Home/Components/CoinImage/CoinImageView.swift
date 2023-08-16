//
//  CoinImageView.swift
//  Crypton
//
//  Created by MBA-0019 on 19/06/23.
//

import SwiftUI
struct CoinImageView: View {
    @StateObject private var ImageVM : coinImageViewModel
    init(coin: CoinModel) {
        _ImageVM = StateObject(wrappedValue: coinImageViewModel(coin: coin))
    }
    var body: some View {
        ZStack
        {
            if let image = ImageVM.image {
                Image(uiImage : image)
                    .resizable()
                    .scaledToFit()
             }
            else if ImageVM.isLoading
            {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryTextColor)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
