//
//  MarketDataService.swift
//  Crypton
//
//  Created by MBA-0019 on 23/06/23.
//

import Foundation
import Combine

class MarketDataService
{
    @Published var marketData : MarketDataModel? = nil
    var marketDataSubscribtion : AnyCancellable?
    
    init()
    {
        getData()
    }
    
    func getData()
    {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else{return}
        
        marketDataSubscribtion =  URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (output) ->Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else
                {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink { (complete) in
                switch complete
                {
                case .finished :
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self]
                (returnedGlobalData) in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscribtion?.cancel()
                
            }

        
    }
}
