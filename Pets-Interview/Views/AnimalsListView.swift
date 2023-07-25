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
    @State var myColorScheme: ColorScheme?
    @State private var isAlertPresented: Bool = false
    @State private var isPullToRefreshEnabled: Bool = false
    
    @Environment(\.colorScheme) var systemColorScheme
    
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
                            ThemeChanger(colorScheme: $myColorScheme)
                        }
                        Text("Nearby results")
                            .foregroundColor(.init(appColor: AppColors.appTextPrimary))
                            .font(AppFonts.Sailec.bold.swiftUIFont(size: 17))
                            .padding(.top, 35)
                            .padding(.bottom, 20)
                    }
                    .padding(.horizontal, 24)
                    AnimalsListView()
                        .ignoresSafeArea()
                }
                .background(
                    Color(appColor: .appBackground)
                        .ignoresSafeArea()
                )
            }
        }
        .onChange(of: myColorScheme) { scheme in
            viewModel.saveColorScheme(scheme ?? systemColorScheme)
        }
        .onChange(of: viewModel.error) { val in
            isAlertPresented = val == .none ? false : true
        }
        
        .onAppear {
            myColorScheme = viewModel.getColorScheme()
            Task {
                await viewModel.getToken()
                await viewModel.getAnimals(page: 1)
            }
        }
        .colorScheme(myColorScheme ?? systemColorScheme)
        
        .alert(isPresented: $isAlertPresented) {
            Alert(
                title: Text(viewModel.error.title),
                message: Text(viewModel.error.errorDescription ?? ""),
                dismissButton: .cancel() {
                    Task {
                        await viewModel.retryRequest()
                    }
                }
            )
        }
    }
    
    private func AnimalsListView() -> some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.animals, id: \.id) { pet in
                    NavigationLink {
                        AnimalDetailView(animal: pet)
                    } label: {
                        PetCell(
                            name: pet.name,
                            tags: pet.tags.firstTag,
                            age: pet.age,
                            distance: pet.distance,
                            photo: pet.photo,
                            gender: pet.gender,
                            publishedAt: pet.publishedAt)
                        .onAppear {
                            Task {
                                if pet == viewModel.animals.last {
                                    await viewModel.loadMoreContent()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
}

struct AnimalsListView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalsListView()
    }
}
