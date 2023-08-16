//
//  CoinRowView.swift
//  Crypton
//
//  Created by MBA-0019 on 16/06/23.
//

import SwiftUI

struct CoinRowView: View {
    let coin : CoinModel
    let showHoldings : Bool
    var body: some View {
        HStack(spacing: 0)
        {
            Text("\(coin.rank)")
                .foregroundColor(Color.theme.secondaryTextColor)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30,height: 30)
            Text("\(coin.symbol.uppercased())")
                .font(.headline)
                .foregroundColor(Color.theme.accentColor)
                .padding(.leading,6)
            Spacer()
            if showHoldings
            {
                VStack
                {
                    Text(coin.currentHoldingsValue.currencyWith6Digits())
                        .foregroundColor(Color.theme.accentColor)
                    Text((coin.currentHoldings ?? 0).asNumberPercentage())
                }
            }
        
            VStack(alignment: .trailing){
                Text("\(coin.currentPrice.currencyWith6Digits())")
                    .bold()
                    .foregroundColor(Color.theme.accentColor)
                Text(coin.priceChangePercentage24H?.asNumberPercentage() ?? "")
                    .foregroundColor(
                        coin.priceChangePercentage24H ?? 0 > 0 ? Color.theme.greenColor : Color.theme.redColor
                        
                    )
            }
            .frame(width: UIScreen.main.bounds.width / 3.5 , alignment: .trailing)
            
        }
        .font(.subheadline)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group
        {
            CoinRowView(coin: dev.coin, showHoldings: true)
                .previewLayout(.sizeThatFits)
            CoinRowView(coin: dev.coin, showHoldings: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        
    }
}
