//
//  AllJsonPlaceholderViewModel.swift
//  JsonPlaceholderTestApp
//
//  Created by Francis Batista on 13/4/25.
//

import SwiftUI
import MySwiftFramework

class AllJsonPlaceholderViewModel: ObservableObject {
    let useCase = JsonPlaceholderUsecase()
    @Published var allDataResponse: [JsonPlaceholderResponse]?
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
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
