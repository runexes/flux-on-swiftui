//
//  ContentView.swift
//  FluxOnSwiftUI
//
//  Created by Alex on 04.06.2020.
//  Copyright © 2020 RunEXEs. All rights reserved.
//

import SwiftUI
import Combine

final class Store<State, Action>: ObservableObject {

    typealias Reducer = (State, Action) -> State
    private let reducer: Reducer
    @Published var state: State

    init(initialState: State, reducer: @escaping Reducer) {
        state = initialState
        self.reducer = reducer
    }

    func dispatch(action: Action) {
        state = reducer(state, action)
    }
}

struct ContentView: View {

    enum CounterAction {
        case increment
        case decrement
    }

    @ObservedObject var store = Store<Int, CounterAction>(initialState: 0) {
        (previousState, action) in
        switch action {
            case .increment:
                return previousState + 1
            case .decrement:
                return previousState - 1
        }
        
    }

    var body: some View {
        VStack {
            VStack(spacing: 30) {
                Text("\(store.state)")
                    .font(.largeTitle)
                HStack {
                    Button(action: {
                        self.store.dispatch(action: .increment)
                    }, label: {
                        Text("Up")
                    })
                    Spacer()
                    Button(action: {
                        self.store.dispatch(action: .decrement)
                    }, label: {
                        Text("Down")
                    })
                }
                .frame(width: 200)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
