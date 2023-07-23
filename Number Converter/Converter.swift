//
//  Converter.swift
//  Number Converter
//
//  Created by Dylan Conklin on 7/19/23.
//

import Foundation

extension String {
    subscript (index: Int) -> String {
        get {
            String(self.dropLast(self.count - (index + 1)).dropFirst(index))
        }
    }
}

func convertNumber (input: String, fromBase: Int, toBase: Int, dictionary: String) -> String {
    let base10number: Int = toBase10(input: input, fromBase: fromBase, dictionary: dictionary)
    print("Base 10: \(base10number)")
    return toBaseX(base10number: base10number, toBase: toBase, dictionary: dictionary)
}

func toBase10 (input: String, fromBase: Int, dictionary: String) -> Int {
    var result: Int = 0
    for pos in 0..<input.count {
        let value: Int = getIndex(of: input[pos], using: dictionary)
        result = result + value * Int(pow(Double(fromBase), Double(pos)))
    }
    return result
}

func toBaseX(base10number: Int, toBase: Int, dictionary: String) -> String {
    var base10number  = base10number
    var result: String = ""
    while base10number != 0 {
        let index: Int = base10number % toBase
        result = dictionary[index] + result
        base10number = base10number / toBase
    }
    return result
}

func lowestPossibleBase (of input: String, using dictionary: String) -> Int {
    if input.isEmpty { return dictionary.count }
    var result: Int = 0
    for pos in 0..<input.count {
        result = max(result, getIndex(of: input[pos], using: dictionary))
    }
    return result + 1
}

func isValidInput (of input: String, using dictionary: String) -> Bool {
    var result: Bool = true
    for pos in 0..<input.count {
        result = dictionary.contains(input[pos])
        if result == false {
            break
        }
    }
    return result
}

func getIndex (of val: String, using dictionary: String, pos: Int = 0) -> Int {
    if (pos == dictionary.count) { return -1 }
    else if (dictionary[pos] == val) { return pos }
    else { return getIndex (of: val, using: dictionary, pos: pos + 1) }
}
