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
    var animals: [AnimalMainInfoViewObject] { get set }
    var error: String { get set }
    var mapperService: AnimalDataMapperProtocol { get }
    
    func getAnimals() async
}

final class AnimalsViewModel: AnimalsViewModelProtocol {
    
    @Published var animals: [AnimalMainInfoViewObject] = []
    @Published var error: String = ""
    
    internal let mapperService: AnimalDataMapperProtocol = AnimalDataMapper()
        
    func getAnimals() async {
        let request = AnimalsRequest()
        let result = await RequestSender.live.send(request: request)
        switch result {
        case let .success(animals):
            self.animals = mapperService.map(animals)
        case let .failure(error):
            self.error = error.localizedDescription
        }
    }
    
}
