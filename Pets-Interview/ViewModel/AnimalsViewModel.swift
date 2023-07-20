//
//  AnimalsViewModel.swift
//  Pets-Interview
//
//  Created by Maksim Khlestkin on 13.07.2023.
//

import Foundation
import Networking

@MainActor
protocol AnimalsViewModelProtocol: ObservableObject {
    var animals: [AnimalViewObject] { get set }
    var choosenAnimal: AnimalViewObject? { get set }
    var error: String { get set }
    var mapperService: AnimalDataMapperProtocol { get }
    
    func getAnimals() async
//    func getAnimal(id: Int) async
}

final class AnimalsViewModel: AnimalsViewModelProtocol {
    
    @Published var animals: [AnimalViewObject] = []
    @Published var choosenAnimal: AnimalViewObject?
    @Published var error: String = ""
    
    internal let mapperService: AnimalDataMapperProtocol = AnimalDataMapper()
    
    private var page = 1
    private let totalPages = 20
        
    func getAnimals() async {
        let request = AnimalsRequest(location: NetworkConstants.MOCK_ZIP, page: page.description)
        let result = await RequestSender.live.send(request: request)
        switch result {
        case let .success(animals):
            self.animals += mapperService.map(animals)
        case let .failure(error):
            self.error = error.localizedDescription
        }
    }
    
    func loadMoreContent(currentItem: AnimalViewObject) async {
        if currentItem == animals.last, (page + 1) <= totalPages {
            page += 1
//            await getAnimals()
        }
    }
    
//    func getAnimal(id: Int) async {
//        let request = AnimalRequest(id: id)
//        let result = await RequestSender.live.send(request: request)
//        switch result {
//        case let .success(animal):
//            print(animal)
//        case let .failure(error):
//            self.error = error.localizedDescription
//        }
//    }
    
}
