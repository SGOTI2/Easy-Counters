//
//  ContentView.swift
//  Counter
//
//  Created by SGOTI2 on 5/29/23.
//

import SwiftUI

struct counter: Encodable, Decodable, Hashable {
    var value: Int
    var title: String
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView: View {
    @Namespace private var scaleAnimation
    
    
    @State var counters: Array<counter>
    func save() {
        if let encoded = try? JSONEncoder().encode(counters) {
            UserDefaults.standard.set(encoded, forKey: "counters")
        }
    }
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "counters") {
            if let decodedItems = try? JSONDecoder().decode([counter].self, from: savedItems) {
                counters = decodedItems
            } else {
                counters = [counter(value: 0, title: "Untitled Counter")]
            }
        } else {
            counters = [counter(value: 0, title: "Untitled Counter")]
        }
    }
    @State var fullScreen = false
    @State var fullIndex = 0
    
    var body: some View {
        VStack {
            if !fullScreen {
                CounterGridView(scaleAnimation: scaleAnimation, counters: $counters, fullScreen: $fullScreen, fullIndex: $fullIndex)
                    .padding()
            } else {
                SlideShow(scaleAnimation: scaleAnimation, counters: $counters, fullScreen: $fullScreen, fullIndex: $fullIndex)
            }
        }.preferredColorScheme(.dark)
            .background(Color(red: 0.0862745098, green: 0.09411764705, blue: 0.10980392156))
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
