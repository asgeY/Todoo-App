//
//  EmptyListView.swift
//  ToDooApp
//
//  Created by Asge Yohannes on 5/23/20.
//  Copyright © 2020 Asge Yohannes. All rights reserved.
//

import SwiftUI

struct EmptyListView: View {
    @State private var isAnimated: Bool = false
    
    let images: [String] = [
        
    "illustration-no1",
    "illustration-no2",
    "illustration-no3"
        
    ]
    
    let tips: [String] = [
        
    "Use your time wisley",
    "Slow and steady wins the race",
    "Keep it short and sweet",
    "Put hard task first",
    "Reward yourslef every task",
    "Collect task ahead of time",
    "Each night schedule for tomorrow",
    "Make life interesting",
    "Do not stress yourself to much"
        
    ]
    var body: some View {
        
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                Image("\(images.randomElement() ?? self.images[0])")
                    .resizable()
                    .frame(minWidth: 256, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
                    .layoutPriority(1)
                
                Text("\(tips.randomElement() ?? self.tips[0])")
                    .layoutPriority(0.5)
                    .font(.system(.headline, design: .rounded))
            }
            .offset(y: isAnimated ? 0 : -50)
            .animation(.easeOut(duration: 1.5))
            .onAppear(perform: {
                self.isAnimated.toggle()
            })
        }
        .padding(.horizontal)
        .opacity(isAnimated ? 1 : 0)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color("ColorBase"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
            .environment(\.colorScheme, .dark)
    }
}
