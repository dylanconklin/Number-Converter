//
//  ContentView.swift
//  Number Converter
//
//  Created by Dylan Conklin on 7/19/23.
//

import SwiftUI

struct ContentView: View {
    @State private var fromBase: Int = 2
    @State private var toBase: Int = 2
    @State private var input: String = ""
    private let dictionary: String = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    private var lowestPossibleBase: Int {
        Number_Converter.lowestPossibleBase(of: input.uppercased(), using: dictionary)
    }
    private var result: String {
        convertNumber(input: String(input.uppercased().reversed()), fromBase: fromBase, toBase: toBase, dictionary: dictionary)
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField(
                    "Input",
                    text: $input
                )
                .textFieldStyle(.roundedBorder)
                // .keyboardType(.namePhonePad)
                
                Stepper("From Base: \(fromBase)",
                        value: $fromBase,
                        in: 2...dictionary.count)
                
                Stepper("To Base: \(toBase)",
                        value: $toBase,
                        in: 2...dictionary.count)
                
                Section {
                    if input.isEmpty {
                    } else if !isValidInput(of: input.uppercased(), using: dictionary) {
                        Text("Error: Input is not valid\nPlease remove all punctuation, symbols, and emojis from input.")
                            .foregroundColor(Color.red)
                    } else if lowestPossibleBase > fromBase {
                        Text("Error: Input is not a valid base \(fromBase) number\nPlease set \"From Base\" to \(lowestPossibleBase)")
                            .foregroundColor(Color.red)
                    } else {
                        Text("Result: \(result)")
                    }
                }
            }
            .navigationTitle("Number Converter")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
