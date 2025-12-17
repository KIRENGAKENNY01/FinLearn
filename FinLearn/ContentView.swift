//
//  ContentView.swift
//  FinLearn
//
//  Created by Kenny.k on 13/11/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20){
            Text("Welcome to Finlearn!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.green)
            Text("Your journey to financial literacy begins here")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
        }
        Button(action:{
            print("Get Started tapped!")
        }){
            Text("Get started")
                .padding()
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(10)
        }
        .padding()
    }
      
}
