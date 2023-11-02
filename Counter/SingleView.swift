//
//  SingleView.swift
//  Counter
//
//  Created by SGOTI2 on 6/17/23.
//

import SwiftUI

struct SingleView: View {
    @State var scaleAnimation: Namespace.ID
    @Binding var counters: Array<counter>
    @Binding var fullScreen: Bool
    @State var fullIndex: Int
    
    func save() {
        if let encoded = try? JSONEncoder().encode(counters) {
            UserDefaults.standard.set(encoded, forKey: "counters")
        }
    }
    var body: some View {
        VStack {
            HStack {
                Spacer()
                TextField("Title", text: Binding(
                    get: { return counters[fullIndex].title },
                    set: { (newValue) in
                        self.counters[fullIndex].title = newValue
                        save()
                        return self.counters[fullIndex].title = newValue}
                )).font(Font.title)
                    .matchedGeometryEffect(id: "Title"+String(fullIndex), in: scaleAnimation)
                Spacer()
                Button {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        fullScreen = false
                        if counters.count > fullIndex {
                            _ = counters.remove(at: fullIndex)
                        }
                    }
                    save()
                } label: {
                    Image(systemName: "minus")
                        .font(Font.title2)
                        .foregroundColor(.secondary)
                        .frame(width: 20, height: 20)
                        .padding()
                }.matchedGeometryEffect(id: "Rem"+String(fullIndex), in: scaleAnimation)
                Button {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        fullScreen.toggle()
                    }
                } label: {
                    Image(systemName: "arrow.down.right.and.arrow.up.left")
                        .font(Font.title2)
                        .foregroundColor(.secondary)
                        .frame(width: 20, height: 20)
                        .padding()
                }.matchedGeometryEffect(id: "Ful"+String(fullIndex), in: scaleAnimation)
            }
            VStack(alignment:.center) {
                Spacer()
                TextField("#", value: Binding(
                    get: { return counters[fullIndex].value },
                    set: { (newValue) in
                        self.counters[fullIndex].value = newValue
                        save()
                        return self.counters[fullIndex].value = newValue}
                ),format:.number)
                    .font(Font.system(size: 70))
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(5)
                    .matchedGeometryEffect(id: "Num"+String(fullIndex), in: scaleAnimation)
                    .keyboardType(.numberPad)
                Spacer()
                HStack {
                    Button {
                        withAnimation(.easeInOut(duration: 0.05)) {
                            counters[fullIndex].value -= 1
                        }
                        save()
                    } label: {
                        Image(systemName: "minus")
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100)
                            .padding()
                            .background(.red)
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }.cornerRadius(10)
                        .matchedGeometryEffect(id: "Add"+String(fullIndex), in: scaleAnimation)
                    Button {
                        withAnimation(.easeInOut(duration: 0.05)) {
                            counters[fullIndex].value += 1
                        }
                        save()
                    } label: {
                        Image(systemName: "plus")
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100)
                            .padding()
                            .background(.green)
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }.cornerRadius(10)
                        .matchedGeometryEffect(id: "Sub"+String(fullIndex), in: scaleAnimation)
                }.cornerRadius(20)
            }
            
        }.matchedGeometryEffect(id: "BG"+String(fullIndex), in: scaleAnimation)
    }
}

struct SingleView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
