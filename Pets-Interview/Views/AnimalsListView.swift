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
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        NavigationView {
            if viewModel.animals.isEmpty {
                ZStack {
                    Color(appColor: .appBackground)
                    ProgressView()
                }
                .ignoresSafeArea()
            } else {
                VStack {
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Hey Spikey!")
                                    .foregroundColor(.init(appColor: AppColors.appTextPrimary))
                                    .font(AppFonts.Sailec.bold.swiftUIFont(size: 20))
                                Text("Adopt a new friend near you!")
                                    .foregroundColor(.init(appColor: AppColors.appTextPrimary))
                                    .font(AppFonts.Sailec.light.swiftUIFont(size: 16))
                            }
                            .padding(.top, 47)
                            Spacer()
                            ThemeChanger()
                        }
                        Text("Nearby results")
                            .foregroundColor(.init(appColor: AppColors.appTextPrimary))
                            .font(AppFonts.Sailec.bold.swiftUIFont(size: 17))
                            .padding(.top, 35)
                            .padding(.bottom, 20)
                    }
                    .padding(.horizontal, 24)
                    ScrollView(showsIndicators: false) {
                        ForEach(viewModel.animals, id: \.id) { pet in
                            NavigationLink {
                                AnimalDetailView(animal: pet)
                            } label: {
                                PetCell(
                                    name: pet.name,
                                    tags: pet.tags,
                                    age: pet.age,
                                    distance: pet.distance,
                                    photo: pet.photo,
                                    gender: pet.gender,
                                    lastSeen: "13 min ago"
                                ) { }
                            }
                        }
                    }
                }
                .background(
                    Color(appColor: .appBackground)
                        .ignoresSafeArea()
                )
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
