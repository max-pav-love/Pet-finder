//
//  AnimalDetailView.swift
//  Pets-Interview
//
//  Created by Maksim Khlestkin on 14.07.2023.
//

import SwiftUI
import UIComponents

struct AnimalDetailView: View {
    @Environment(\.presentationMode) private var presentationMode
    private let animal: AnimalViewObject
    
    init(animal: AnimalViewObject) {
        self.animal = animal
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                AppImage(url: animal.photo)
                    .frame(width: UIScreen.main.bounds.width)
                    .frame(minHeight: 260)
                    .clipped()
                    .edgesIgnoringSafeArea(.top)
                header
            }
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    mainInfo
                    animalInfo
                    quickInfoCells
                    ownerInfo
                    ActionButton(title: "Adopt me") { }
                        .padding(.vertical, 35)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 35)
            }
            Spacer()
        }
        .navigationBarHidden(true)
        .background(Color(appColor: .appBackground))
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private var header: some View {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(appImage: .Left)
                        .frame(width: 24, height: 24)
                }
                
                Spacer()
                
                Button {
                } label: {
                    Image(appImage: .Heart)
                        .frame(width: 24, height: 24)
                }
            }
            .padding(.horizontal)
            .padding(.top)
    }
    
    private var mainInfo: some View {
        HStack {
            PetMainInfoStack(
                stackType: .detail(lastSeen: animal.publishedAt),
                metersAway: animal.distance,
                name: animal.name
            )
            Spacer()
            GenderStack(
                gender: animal.gender,
                additionalText: animal.tags.detailTags
            )
        }
    }
    
    private var animalInfo: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("My Story")
                .font(AppFonts.Sailec.bold.swiftUIFont(size: 16))
                .foregroundColor(.init(appColor: .appTextPrimary))
            Text(animal.description)
                .font(AppFonts.Sailec.regular.swiftUIFont(size: 14))
                .foregroundColor(.init(appColor: .appTextSecondary))
        }
        .padding(.top, 36)
    }
    
    private var quickInfoCells: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Quick Info")
                .font(AppFonts.Sailec.bold.swiftUIFont(size: 16))
                .foregroundColor(.init(appColor: .appTextPrimary))
            HStack {
                QuickInfoCell(title: animal.age, description: "Age")
                Spacer()
                QuickInfoCell(title: animal.color, description: "Color")
                Spacer()
                QuickInfoCell(title: animal.size, description: "Size")
            }
        }
        .padding(.top, 36)
    }
    
    private var ownerInfo: some View {
        VStack(alignment: .leading) {
            Text("Owner Info")
                .font(AppFonts.Sailec.bold.swiftUIFont(size: 16))
                .foregroundColor(.init(appColor: .appTextPrimary))
            HStack {
                Image(appImage: .No_Image)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(32)
                VStack(alignment: .leading, spacing: 10) {
                    Text(animal.ownersEmail ?? "")
                        .font(AppFonts.Sailec.medium.swiftUIFont(size: 14))
                        .foregroundColor(.init(appColor: .appTextPrimary))
                    Text(animal.ownersPhone ?? "")
                        .font(AppFonts.Sailec.regular.swiftUIFont(size: 12))
                        .foregroundColor(.init(appColor: .appTextSecondary))
                }
                .padding(.trailing, 16)
                
                Spacer()
                
                Button {
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 32)
                            .fill(Color(appColor: .appBlue))
                            .frame(width: 40, height: 40)
                        Image(appImage: .Messanger)
                            .resizable()
                            .frame(width: 17, height: 17)
                    }
                }
            }
        }
        .padding(.top, 36)
    }
    
}

struct AnimalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalDetailView(
            animal: .init(
                id: 1,
                name: "22",
                description: "Description",
                gender: .female,
                age: "21",
                distance: "12",
                publishedAt: "12",
                photo: nil,
                tags: .init(firstTag: "Good", detailTags: "Good"),
                ownersPhone: "+222",
                ownersEmail: "+111",
                color: "Red",
                size: "Big"
            )
        )
    }
}
