//
//  CoinImageService.swift
//  Crypton
//
//  Created by MBA-0019 on 19/06/23.
//

import Foundation
import Combine
import SwiftUI

class CoinImageService: ObservableObject {
    @Published var image: UIImage? = nil
    private var coinSubscribtion: AnyCancellable?
    private let coin : CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "Images_Content"
    private let imageName : String
    init(coin : CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    func getCoinImage(){
        if let savedImage = fileManager.getImage(folderName: imageName, imageName: folderName){
           image = savedImage
        }
        else{
            downloadCoinImage()
        }
    }
    
    func downloadCoinImage() {
        guard let url = URL(string: coin.image) else {
            return
        }
        
        coinSubscribtion = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { data, response -> UIImage? in
                return UIImage(data: data)!
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] returnedImage in
                guard let self = self , let downloadedImage = returnedImage else {return}
                self.image = downloadedImage
                self.coinSubscribtion?.cancel()
                self.fileManager.getImageDownload(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            }
    }
}
