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
        Group {
            if viewModel.animals.isEmpty {
                ProgressView()
            } else {
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Hey Spikey!")
                        Text("Adopt a new friend near you!")
                    }
                    .padding(.top, 47)
                }
                Text("Nearby results")
                    .padding(.top, 35)
                
                ScrollView {
                    ForEach(viewModel.animals) { pet in
                        PetCell(
                            name: pet.name,
                            tags: pet.tags,
                            age: pet.age,
                            distance: pet.distance,
                            photo: pet.photo,
                            gender: pet.gender,
                            lastSeen: pet.lastSeen
                        ) {
                            
                        }
                    }
                }
            }
        }
        .onAppear {
            // TODO: - Fix
            UserDefaults.standard.set(nil, forKey: "jwt_token")
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
