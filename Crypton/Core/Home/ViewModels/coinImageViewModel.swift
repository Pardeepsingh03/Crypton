//
//  coinImageViewModel.swift
//  Crypton
//
//  Created by MBA-0019 on 19/06/23.
//

import Foundation
import SwiftUI
import Combine

class coinImageViewModel : ObservableObject {
    @Published var image : UIImage? = nil
    @Published var isLoading : Bool = false
    private let coin : CoinModel
    private let dataServicesImage : CoinImageService
    private var cancelables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.dataServicesImage = CoinImageService(coin: coin)
        self.coin = coin
        addSubscribers()
        self.isLoading = true
     }
  private func addSubscribers() {
        dataServicesImage.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { (returnedImage) in
                self.image = returnedImage
                
            }
            .store(in: &cancelables)
       }
}
