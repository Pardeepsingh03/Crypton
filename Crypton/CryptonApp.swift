//
//  CryptonApp.swift
//  Crypton
//
//  Created by MBA-0019 on 16/06/23.
//

import SwiftUI

@main
struct CryptonApp: App {
    
    @StateObject private var vm = HomeViewModel()
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accentColor)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor:UIColor(Color.theme.accentColor)]
    }
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
