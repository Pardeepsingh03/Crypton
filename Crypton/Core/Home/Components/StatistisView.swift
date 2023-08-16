//
//  StatistisView.swift
//  Crypton
//
//  Created by MBA-0019 on 22/06/23.
//

import SwiftUI

struct StatistisView: View {
    
    let stat : StatistisModel
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryTextColor)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accentColor)
            HStack {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees:( stat.percentageValue ?? 0)  >= 0 ? 0 : 180))
                Text(stat.percentageValue?.asNumberPercentage() ?? "")
                    .font(.caption)
                .bold()
                
            }
            .foregroundColor(( stat.percentageValue ?? 0)  >= 0 ? Color.theme.greenColor : Color.theme.redColor)
            .opacity(stat.percentageValue == nil ? 0.0 : 1.0)
        }
    }
}

struct StatistisView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            StatistisView(stat: dev.stat1)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
            StatistisView(stat: dev.stat2)
                .previewLayout(.sizeThatFits)
            StatistisView(stat: dev.stat3)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        
    }
}
