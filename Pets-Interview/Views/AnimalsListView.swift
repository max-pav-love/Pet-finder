//
//  AnimalsListView.swift
//  Pets-Interview
//
//  Created by Maksim Khlestkin on 13.07.2023.
//

import SwiftUI
import UIComponents
import Networking

struct AnimalsListView: View {
    @StateObject private var viewModel = AnimalsViewModel()
    var body: some View {
        ScrollView {
            ForEach(viewModel.animals, id: \.name) { pet in
                PetCell(
                    name: pet.name,
                    tags: pet.tags,
                    age: pet.age,
                    distance: "22",
                    photo: Image(""),
                    gender: pet.gender,
                    lastSeen: "2"
                ) {
                    
                }
            }
        }
        .onAppear {
            Task {
                guard await RequestSender.live.sendTokenRequest() == nil else {
                    return
                }
                await viewModel.getAnimals()
            }
        }
    }
}

struct AnimalsListView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalsListView()
    }
}
