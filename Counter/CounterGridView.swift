//
//  CounterGridView.swift
//  Counter
//
//  Created by SGOTI2 on 6/17/23.
//

import SwiftUI

struct CounterGridView: View {
    @State var scaleAnimation: Namespace.ID
    @Binding var counters: Array<counter>
    @Binding var fullScreen: Bool
    @Binding var fullIndex: Int
    
    func save() {
        if let encoded = try? JSONEncoder().encode(counters) {
            UserDefaults.standard.set(encoded, forKey: "counters")
        }
    }
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView() {
            HStack {
                Text("Counters")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 20)
                    .padding(.bottom, 30)
                Spacer()
            }
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(counters.indices, id: \.self) {i in
                    VStack {
                        HStack {
                            TextField("Title", text: Binding(
                                get: { return counters[i].title },
                                set: { (newValue) in
                                    self.counters[i].title = newValue
                                    save()
                                    return self.counters[i].title = newValue}
                            )).font(.callout)
                                .foregroundColor(.secondary)
                                .matchedGeometryEffect(id: "Title"+String(i), in: scaleAnimation)
                            Spacer()
                            Button {
                                withAnimation(.easeOut(duration: 0.4)) {
                                    if counters.count > i {
                                        _ = counters.remove(at: i)
                                    }
                                }
                                save()
                            } label: {
                                Image(systemName: "minus")
                                    .font(.callout)
                                    .foregroundColor(.secondary)
                                    .frame(width: 20, height: 20)
                            }.matchedGeometryEffect(id: "Rem"+String(i), in: scaleAnimation)
                            Button {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                    fullIndex = i
                                    fullScreen.toggle()
                                }
                            } label: {
                                Image(systemName: "arrow.up.left.and.arrow.down.right")
                                    .font(.callout)
                                    .foregroundColor(.secondary)
                                    .frame(width: 20, height: 20)
                            }.matchedGeometryEffect(id: "Ful"+String(i), in: scaleAnimation)
                        }
                        VStack(alignment:.center) {
                            TextField("#", value: Binding(
                                get: { return counters[i].value },
                                set: { (newValue) in
                                    self.counters[i].value = newValue
                                    save()
                                    return self.counters[i].value = newValue}
                            ),format:.number)
                                .multilineTextAlignment(.center)
                                .font(.largeTitle)
                                .bold()
                                .padding(5)
                                .matchedGeometryEffect(id: "Num"+String(i), in: scaleAnimation)
                                .keyboardType(.numberPad)
                            HStack {
                                Button {
                                    withAnimation(.easeInOut(duration: 0.05)) {
                                        counters[i].value -= 1
                                    }
                                    save()
                                } label: {
                                    Image(systemName: "minus")
                                        .frame(height: 10)
                                        .padding()
                                        .background(.red)
                                        .foregroundColor(.white)
                                }.cornerRadius(5)
                                    .matchedGeometryEffect(id: "Add"+String(i), in: scaleAnimation)
                                Button {
                                    withAnimation(.easeInOut(duration: 0.05)) {
                                        counters[i].value += 1
                                    }
                                    save()
                                } label: {
                                    Image(systemName: "plus")
                                        .frame(height: 10)
                                        .padding()
                                        .background(.green)
                                        .foregroundColor(.white)
                                }.cornerRadius(5)
                                    .matchedGeometryEffect(id: "Sub"+String(i), in: scaleAnimation)
                            }.cornerRadius(10)
                        }
                    }.padding(10)
                        .background(Color(red: 36/255, green: 38/255, blue: 42/255))
                        .cornerRadius(10)
                        .matchedGeometryEffect(id: "BG"+String(i), in: scaleAnimation)
                }
                VStack {
                    Spacer()
                    Button {
                        withAnimation(.easeOut(duration: 0.4)) {
                            counters.append(counter(value: 0, title: "Counter #"+String(counters.count+1)))
                        }
                        save()
                        
                    } label: {
                        Image(systemName: "plus")
                            .padding(20)
                            .foregroundColor(.white)
                            .background(Color(red: 44/255, green: 46/255, blue: 54/255))
                            .cornerRadius(50)
                            .shadow(radius: 20)
                    }.animation(.none)
                        .padding(10)
                    Spacer()
                }
            }
        }
    }
}

struct CounterGridView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
