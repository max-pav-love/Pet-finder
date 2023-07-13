//
//  ContentView.swift
//  Pets-Interview
//
//  Created by Maksim Khlestkin on 12.07.2023.
//

import SwiftUI
import UIComponents

struct ContentView: View {
    var body: some View {
        VStack {
            PetCell(
                name: "Parkinson",
                tags: ["Playful"],
                age: "2yrs",
                distance: "381m away",
                photo: Image("chevron.left"),
                gender: .female,
                lastSeen: "13 min ago"
            ) { }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
