//
//  StatistisModel.swift
//  Crypton
//
//  Created by MBA-0019 on 22/06/23.
//

import Foundation

struct StatistisModel : Identifiable{
    var id = UUID().uuidString
    var title : String
    var value : String
    var percentageValue : Double?
    
    init(id: String = UUID().uuidString, title: String, value: String, percentageValue: Double? = nil) {
        self.id = id
        self.title = title
        self.value = value
        self.percentageValue = percentageValue
    }
}
