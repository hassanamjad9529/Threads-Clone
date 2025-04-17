//
//  profileViewModel.swift
//  Threads Clone
//
//  Created by Hassan Amjad on 19/03/2025.
//

import Foundation
import Combine

class ProfileViewModel : ObservableObject{
    @Published var currentUser: User?
    private var cancellables = Set<AnyCancellable>()
    init(){
        setupSubscribers()
    }

    private func setupSubscribers() {
        UserService.shared.$currentUser.sink {

            [weak self] user in self?.currentUser = user
            print(
                "DEBUG user in viewmodel from combine is \(String(describing: user))"
            )
        }.store(in: &cancellables)
    }
}
