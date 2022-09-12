//
//  ContentView.swift
//  sample2
//
//  Created by Eric Nguyen on 9/5/22.
//

// google in swiftUI

// idea : can make this into multiplayer game; who can get it in less guesses
// can add small particle fx easily
import SwiftUI

/// class: a reference
/// - can change parameters
/// struct: not a reference
/// - can't change parameters because its a value type (immutable)
/// - easier to debug

let lowerLimit = 1
let upperLimit = 100

let secret = Int.random(in: lowerLimit...upperLimit)

/// View basically a protocol; forces ContentView to obey protocol
struct ContentView: View {
    /// - State : set of properties
    /// - @State : variable can be bound; monitors the variable when it changes
    @State private var guess = ""
    
    private func standardText(warmth: Int, stringInput: String) -> some View {
        
        var color: Color = .black
        
        // higher warmth = more red
        if(warmth == 0) {
            color = .black
        } else if (warmth == 1) {
            color = Color(red: 166/255, green: 204/255, blue: 212/255)
        } else if (warmth == 2) {
            color = Color(red: 240/255, green: 215/255, blue: 113/255)
        } else if (warmth == 3) {
            color = Color(red: 211/255, green: 98/255, blue: 27/255)
        } else if (warmth == 4){
            color = .red
        } else {
            color = Color(red: 220/255, green: 208/255, blue: 1.0)
        }
        
        let format: some View = Text(stringInput)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .font(.system(size: 15, design: .rounded))
            .foregroundColor(color)
            .padding()
        
        return format
    }
    
    /// Some makes view --> any type (stack, text, textfield, etc.); not a generic
    var body: some View {
        
        /// stacking objects (text fields) vertically; HStack = horizontally
        VStack{
            standardText(warmth: 0,
                         stringInput: "Enter a number between \(lowerLimit) to \(upperLimit)")
            
            /// displays content (guess var)
            /// monitors content of guess
            Text("Your guess: \(guess)")
                /// font modifiers
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .font(.system(size: 40, design: .rounded))
                /// rgb = bytes; each value is fraction of byte
                .foregroundColor(Color(red: 220/255, green: 208/255, blue: 1.0, opacity: 1.0))
                .padding()
            
            /// concept: binding
            /// receives user input (numbers) --> constantly monitors guess
            TextField("Your Guess:", text: $guess)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.center)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if let userGuess = Int(guess) {
                if userGuess == secret {
                    standardText(warmth: 5,
                                 stringInput: "You got it!")
                    // tried exp (upperLimit * n) -> runtime error
                } else if abs(userGuess - secret) <= (3) {
                    standardText(warmth: 4,
                                 stringInput: "it's getting h o t.")
                } else if abs(userGuess - secret) <= (10) {
                    standardText(warmth: 3,
                                 stringInput: "pretty warm!")
                } else if abs(userGuess - secret) <= (25) {
                    standardText(warmth: 2,
                                 stringInput: "eh you're somewhat close")
                } else {
                    standardText(warmth: 1,
                                 stringInput: "yeah you're way off.")
                }
            }
            
            }
        
        }

    // next task: change "Your guess" according to guess amount and guess values
    // -
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
