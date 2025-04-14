//
//  JsonPlaceholderViewModel.swift
//  JsonPlaceholderTestApp
//
//  Created by Francis Batista on 13/4/25.
//
import SwiftUI
import MySwiftFramework

class JsonPlaceholderViewModel: ObservableObject {
    let useCase = JsonPlaceholderUsecase()
    @Published var id: String = ""
    @Published var dataResponse: JsonPlaceholderResponse?
    @Published var errorMessage: String = ""
    @Published var allDataResponse: [JsonPlaceholderResponse]?
    @Published var isLoading: Bool = false
    
    func clearVariables() {
        id = ""
        dataResponse = nil
        allDataResponse = nil
        errorMessage = ""
        isLoading = false
    }
    
    @MainActor
    func fetchData() {
        Task {
            let response = await useCase.getJsonPlaceholderData(id: Int(id) ?? 1)
            switch response {
            case .success(let data):
                dataResponse = data
            case .failure(let error):
                dataResponse = nil
                errorMessage = error.errorDescription ?? ""
            }
        }
    }
    
    @MainActor
    func fetchAllData() {
        Task {
            isLoading = true
            let response = await useCase.getAllJsonPlaceholderData()
            isLoading = false
            switch response {
            case .success(let data):
                allDataResponse = data
            case .failure(let error):
                allDataResponse = nil
                errorMessage = error.errorDescription ?? ""
            }
        }
    }
}
