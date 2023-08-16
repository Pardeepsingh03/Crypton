//
//  HomeStatisView.swift
//  Crypton
//
//  Created by MBA-0019 on 22/06/23.
//

import SwiftUI

struct HomeStatisView: View {
    @EnvironmentObject private var vm : HomeViewModel
    @Binding var showPortfolio : Bool
    
    var body: some View {
       HStack
        {
            ForEach(vm.statValues) { stats in
                StatistisView(stat: stats)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,alignment: showPortfolio ? .trailing : .leading)
    }
}

struct HomeStatisView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatisView(showPortfolio: .constant(false))
            .environmentObject(dev.homeVM)
    }
}
