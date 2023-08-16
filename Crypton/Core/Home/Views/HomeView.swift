//
//  HomeView.swift
//  Crypton
//
//  Created by MBA-0019 on 16/06/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm : HomeViewModel
    @State private var iconState : Bool = false
    @State private var showPortfolioSheet : Bool = false
   
    var body: some View {
      ZStack { //background layer
            Color.theme.backGroundColor
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioSheet) {
                    PortfolioView()
                        .environmentObject(vm)
                }
            VStack {
                HStack {
                    CircleButtonView(iconName: iconState ? "plus" : "info")
                        .animation(_:.none)
                        .onTapGesture {
                            if iconState {
                                showPortfolioSheet.toggle()
                                    
                            }
                        }
                        .background(
                       CircleButtonAnimation(stateChange: $iconState)
                        )
                    Spacer()
                    Text( iconState ? "Portfolio" : "Live Prices")
                        .animation(.none)
                        .font(.headline)
                       // .fontWeight(.heavy)
                       // .bold()
                        .foregroundColor(Color.theme.accentColor)
                    Spacer()
                    CircleButtonView(iconName: "chevron.right")
                        .rotationEffect(Angle(degrees: iconState ? 180 : 0))
                        .onTapGesture {
                            withAnimation(.spring())
                            {
                                iconState.toggle()
                            }
                        }
                  }
                .padding(.horizontal)
                Spacer(minLength: 0)
                HomeStatisView(showPortfolio: $iconState)
                SearchBarView(serachText: $vm.searchText)
                if iconState {
                    HStack{
                        Text("Coins")
                        Spacer()
                        Text("Holdings")
                        Text("Price")
                            .frame(width: UIScreen.main.bounds.width / 3.5 , alignment: .trailing)
                    }
                    .padding(.horizontal,30)
                    .font(.caption)
                    .foregroundColor(Color.theme.secondaryTextColor)
                }
                if !iconState {
                    HStack{
                        Text("Coins")
                        Spacer()
                        Text("Price")
                            .frame(width: UIScreen.main.bounds.width / 3.5 , alignment: .trailing)
                    }
                    .padding(.horizontal,30)
                    .font(.caption)
                    .foregroundColor(Color.theme.secondaryTextColor)
                    
                }
               if !iconState {
                   List{
                       ForEach(vm.allCoins) { coins in
                           CoinRowView(coin: coins, showHoldings: false)
                       }
                   }
                   .listStyle(.plain)
                   .transition(.move(edge: .leading))
               }
                if iconState {
                    List{
                        ForEach(vm.portfolioCoins) { coins in
                            CoinRowView(coin: coins, showHoldings: true)
                        }
                    }
                    .listStyle(.plain)
                    .transition(.move(edge: .trailing))
                 }
             }
         }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
    }
}
