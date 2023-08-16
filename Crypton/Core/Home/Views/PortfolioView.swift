import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantity : String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                coinLogoList
               if let selectedCoin = selectedCoin {
                    VStack(spacing: 20) {
                        HStack {
                            Text("Current price of \(selectedCoin.symbol.uppercased())")
                            Spacer()
                            Text(selectedCoin.currentPrice.currencyWith6Digits() )
                        }
                        Divider()
                        HStack {
                            Text("Amount you holding")
                            Spacer()
                            TextField("Ex : 1.4", text: $quantity)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                        }
                        Divider()
                        HStack {
                            Text("Current value")
                            Spacer()
                            Text(getCurrentValue().currencyWith6Digits())
                        }
                        
                    }
                    .padding()
                    .font(.headline)
                   
                }
            }
            .navigationBarTitle("Edit Portfolio")
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .font(.headline)
            }), trailing: Text("Save")
                .font(.headline))
        
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(HomeViewModel()) // Update with the appropriate environment object
    }
}

extension PortfolioView {
    private var coinLogoList: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                SearchBarView(serachText: $vm.searchText)

                ScrollView(.horizontal, showsIndicators: true) {
                    LazyHStack(spacing: 10) {
                        ForEach(vm.allCoins) { coin in
                            CoinLogoView(coin: coin)
                                .padding(4)
                                .frame(width: 75)
                                .onTapGesture {
                                    withAnimation {
                                        selectedCoin = coin
                                    }
                                }
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(selectedCoin?.id == coin.id ? Color.theme.greenColor : Color.clear, lineWidth: 1)
                                )
                        }
                    }
                    .frame(height: 100)
                    .padding(.leading)
                    
                   
                }
            }
        }
    }
    
    private func getCurrentValue() -> Double {
        if let value = Double(quantity){
            return value * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
}
