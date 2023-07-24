//
//  AnimalsViewModel.swift
//  Pets-Interview
//
//  Created by Maksim Khlestkin on 13.07.2023.
//

import Foundation
import Networking
import SwiftUI

@MainActor
protocol AnimalsViewModelProtocol: ObservableObject {
    var animals: [AnimalViewObject] { get set }
    var choosenAnimal: AnimalViewObject? { get set }
    var error: String { get set }
    var mapperService: AnimalDataMapperProtocol { get }
    
    func getToken() async
    
    func getAnimals() async
    func loadMoreContent(currentItem: AnimalViewObject) async
    
    func saveColorScheme(_ colorSceheme: ColorScheme)
    func getColorScheme() -> ColorScheme?
}

final class AnimalsViewModel: AnimalsViewModelProtocol {
    
    @AppStorage("color_scheme") var savedSceme: String = "light"
    
    @Published var animals: [AnimalViewObject] = []
    @Published var choosenAnimal: AnimalViewObject?
    @Published var error: String = ""
    
    let mapperService: AnimalDataMapperProtocol = AnimalDataMapper()
    
    private var currentPage = 1
    private var totalPages = 0
    
    func getToken() async {
        if let error = await RequestSender.live.sendTokenRequest() {
            print(error.localizedDescription)
        }
    }
    
    func getAnimals() async {
        let request = AnimalsRequest(location: NetworkConstants.MOCK_ZIP, page: currentPage.description)
        let result = await RequestSender.live.send(request: request)
        switch result {
        case let .success(response):
            self.animals += mapperService.map(response)
            totalPages = response.pagination.total_pages
        case let .failure(error):
            self.error = error.localizedDescription
        }
    }
    
    func loadMoreContent(currentItem: AnimalViewObject) async {
        if currentItem == animals.last, (currentPage + 1) <= totalPages {
            currentPage += 1
            //            await getAnimals()
        }
    }
    
    func saveColorScheme(_ colorSceheme: ColorScheme) {
        switch colorSceheme {
        case .light:
            guard savedSceme != "light" else { return }
            savedSceme = "light"
        case .dark:
            guard savedSceme != "dark" else { return }
            savedSceme = "dark"
        @unknown default:
            print("ERR")
        }
    }
    
    func getColorScheme() -> ColorScheme? {
        switch savedSceme {
        case "light":
            return .light
        case "dark":
            return .dark
        default:
            return nil
        }
    }
    
}
