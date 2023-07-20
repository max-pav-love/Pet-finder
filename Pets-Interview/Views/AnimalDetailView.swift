//
//  AnimalDetailView.swift
//  Pets-Interview
//
//  Created by Maksim Khlestkin on 14.07.2023.
//

import SwiftUI
import UIComponents

struct AnimalDetailView: View {
    private let animal: AnimalMainInfoViewObject
    
    init(animal: AnimalMainInfoViewObject) {
        self.animal = animal
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            AppImage(url: URL(string: ""))
                .frame(width: UIScreen.main.bounds.width, height: 346)
            ScrollView {
                HStack {
                    PetMainInfoStack(
                        stackType: .detail(lastSeen: "22"),
                        metersAway: "12 m",
                        name: "Peterson"
                    )
                    Spacer()
                    GenderStack(
                        gender: .female,
                        additionalText: "2yrs | Playful"
                    )
                }
                .padding(.horizontal, 24)
            }
        }
        .background(Color(appColor: .appBackground))
    }
    
}

struct AnimalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalDetailView(
            animal: .init(
                id: 1,
                name: "22",
                gender: .female,
                age: "21",
                distance: "12",
                lastSeen: "12",
                photo: nil,
                tags: []
            )
        )
    }
}
