//
//  CircleButtonAnimation.swift
//  Crypton
//
//  Created by MBA-0019 on 16/06/23.
//

import SwiftUI

struct CircleButtonAnimation: View {
    @Binding var stateChange : Bool
    var body: some View {
       Circle()
            .stroke(lineWidth: 5.0)
            .scale(stateChange ? 1.0 : 0.0)
            .opacity(stateChange ? 0.0 : 1.0)
            .animation(stateChange ? Animation.easeOut(duration: 1.0) : .none)
    }
}

struct CircleButtonAnimation_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimation(stateChange: .constant(false))
            .frame(width: 50,height: 50)
    }
}
