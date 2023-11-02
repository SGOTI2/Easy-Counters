//
//  SlideShow.swift
//  Counter
//
//  Created by SGOTI2 on 6/17/23.
//

import SwiftUI

struct SlideShow: View {
    @State var scaleAnimation: Namespace.ID
    @Binding var counters: Array<counter>
    @Binding var fullScreen: Bool
    @Binding var fullIndex: Int
    var body: some View {
        TabView(selection: $fullIndex) {
            ForEach(counters.indices, id: \.self) { counter in
                SingleView(scaleAnimation: scaleAnimation, counters: $counters, fullScreen: $fullScreen, fullIndex: counter)
                    .padding()
            }
        }.tabViewStyle(.page)
    }
}

struct SlideShow_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
