//
//  EndEditing.swift
//  Crypton
//
//  Created by MBA-0019 on 20/06/23.
//

import Foundation
import SwiftUI

extension UIApplication{
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
