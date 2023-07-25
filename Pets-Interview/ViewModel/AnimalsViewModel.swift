//
//  AnimalsViewModel.swift
//  Pets-Interview
//
//  Created by Maksim Khlestkin on 13.07.2023.
//

import Foundation
import Networking
import SwiftUI
import Combine

@MainActor
protocol AnimalsViewModelProtocol: ObservableObject {
    var animals: [AnimalViewObject] { get set }
    var choosenAnimal: AnimalViewObject? { get set }
    var error: AnimalsViewModel.Errors { get set }
    
    func getToken() async
    
    func getAnimals(page: Int, request: AnimalsRequest?) async
    func loadMoreContent() async
    func retryRequest() async
    
    func saveColorScheme(_ colorSceheme: ColorScheme)
    func getColorScheme() -> ColorScheme?
}

final class AnimalsViewModel: AnimalsViewModelProtocol {
    
    @AppStorage("color_scheme") var savedSceme: String = "light"
    
    @Published var animals: [AnimalViewObject] = []
    @Published var choosenAnimal: AnimalViewObject?
    @Published var error: Errors = .none
    
    private let mapperService: AnimalDataMapperProtocol = AnimalDataMapper()
    
    private var currentPage = 1
    private var totalPages = 0
        
    func getToken() async {
        if let error = await RequestSender.live.sendTokenRequest() {
            self.error = .authError(error.localizedDescription)
        }
    }
    
    func getAnimals(page: Int, request: AnimalsRequest? = nil) async {
        let request = request ?? AnimalsRequest(
            location: NetworkConstants.MOCK_ZIP,
            page: currentPage.description)
        let result = await RequestSender.live.send(request: request)
        switch result {
        case let .success(response):
            self.animals += mapperService.map(response)
            totalPages = response.pagination.total_pages
            currentPage += 1
        case let .failure(error):
            self.error = .networkError(error.localizedDescription, request)
        }
    }
    
    func loadMoreContent() async {
        guard currentPage + 1 <= totalPages else { return error = .pagination }
        await getAnimals(page: currentPage + 1)
    }
    
    func retryRequest() async {
        switch error {
        case .authError:
            await getToken()
        case let .networkError(_, request):
            await getAnimals(page: currentPage, request: request)
        default:
            break
        }
        error = .none
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
            error = .undefined
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
    
    enum Errors: LocalizedError, Equatable {
        case authError(String)
        case networkError(String, AnimalsRequest)
        case pagination
        case undefined
        case none
        
        var title: String {
            switch self {
            case .authError:
                return "Authorization error"
            case .networkError:
                return "Network Error"
            case .pagination:
                return "You have seen all the animals nearby"
            case .undefined:
                return "Undefined error"
            default:
                return ""
            }
        }
        
        var errorDescription: String? {
            switch self {
            case let .authError(err):
                return err
            case let .networkError(err, _):
                return err
            default:
                return nil
            }
        }
        
        static func == (lhs: AnimalsViewModel.Errors, rhs: AnimalsViewModel.Errors) -> Bool {
            lhs.errorDescription == rhs.errorDescription
        }
    }
    
}
