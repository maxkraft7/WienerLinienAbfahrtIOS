//
//  ContentView.swift
//  HelloWorld
//
//  Created by Telekomlab6 on 04.10.23.
//

import SwiftUI

struct ContentView: View {
    
    // nur wenn die variablen als state markiert sind können sie sich bei
    // der laufzeit ändern
    
    @State
    private var buttonText: String = "Klick mich";
    
    @State
    var clickCounter: Int = 0;
    
    @State
    private var textfieldText: String = ""
    
    var body: some View {
        VStack{
            Text("Hello!")
                .padding()
            
            // Nehmen den raum ein den sie maximal zur Verfügung haben
            Spacer()
            
            Text("Hello!")
                .padding()
            
            // UI Komponenten horizontal nebeneinander
            HStack{
                Text("links").padding()
                Text("rechts").padding()
            }
            Button(action: {
                self.clickCounter += 1;
                self.buttonText = "Neuer Text " + String(self.clickCounter)
            }, label: {
                Text(self.buttonText)
            })
            
            // mit einem $ kann man ein binding erzeugen
            TextField("Hint", text: self.$textfieldText)
            
            Text("Textfield Text: \(self.addName(name: self.textfieldText))").padding()
            
            // fixen abstand vom spacer festlgen
            Spacer().frame(height: 30.0)
            
        }
        
    }
    
    // in einer contentview klasse können auch funktionen erstellt werden
    func addName(name: String) -> String {
        return "Hello, \(name)"
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
