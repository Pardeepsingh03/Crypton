//
//  CoinLogoView.swift
//  Crypton
//
//  Created by MBA-0019 on 26/06/23.
//

import SwiftUI

struct CoinLogoView: View {
    
    var coin : CoinModel
    var body: some View {
        VStack{
            CoinImageView(coin: coin)
                .frame(width: 50,height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accentColor)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .foregroundColor(Color.theme.secondaryTextColor)
                .font(.caption)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

struct CoinLogoView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            CoinLogoView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
            CoinLogoView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
       
    }
}
