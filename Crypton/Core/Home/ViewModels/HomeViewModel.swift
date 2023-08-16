//
//  HomeViewModel.swift
//  Crypton
//
//  Created by MBA-0019 on 19/06/23.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var statValues : [StatistisModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText : String = ""
    private let coinDataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    private let marketService = MarketDataService()
    
    init() { getAllCoins() }
    
    func getAllCoins() {
        $searchText.combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5) , scheduler: DispatchQueue.main)
            .map { (text,startingCoins) -> [CoinModel] in
                guard !text.isEmpty else {
                    return startingCoins
                }
                let lowerCasedText = text.lowercased()
                 return startingCoins.filter { (coin) -> Bool in
                    return coin.name.lowercased().contains(lowerCasedText) ||
                    coin.symbol.lowercased().contains(lowerCasedText) ||
                    coin.id.lowercased().contains(lowerCasedText)
                }
             }
            .sink { [weak self] (receviedValue) in
                self?.allCoins = receviedValue
            }
            .store(in: &cancellables)
        marketService.$marketData
            .map{ (marketDataModel) -> [StatistisModel] in
                var stats = [StatistisModel]()
                guard let data = marketDataModel else { return stats }
                let marketCap = StatistisModel(title: "Market Cap", value: data.marketCap , percentageValue: data.marketCapChangePercentage24HUsd)
                let volume = StatistisModel(title:"24h Volume", value: data.volume)
                let btcDominace = StatistisModel(title: "BTC Dominance", value: data.btcDominance)
                let portfolio = StatistisModel(title: "Portfolio", value: "$0.00",percentageValue: 0)
                stats.append(contentsOf: [
                    marketCap,
                    volume,
                    btcDominace,
                    portfolio
                ])
                return stats
            }
            .sink { [weak self] (returnedStats) in
                self?.statValues = returnedStats
            }
            .store(in: &cancellables)

    }
}

