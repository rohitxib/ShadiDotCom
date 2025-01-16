//
//  CandidateListModel.swift
//  ShadiDotCom
//
//  Created by Rohit on 15/01/25.
//

import Foundation
import Combine
import SwiftUI

class UserListViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    @Published var flights = [Welcome]()
    @Published var personList =  [Person]()

    func getApiData() {
        NetworkManager.shared.getData(endpoint: .flights, type: Welcome.self)
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print("Error is \(err.localizedDescription)")
                case .finished:
                    print("Finished")
                }
            }
            receiveValue: { [weak self] PersonsData in
                print("mydata\(PersonsData)")
                self?.savePersonsInDataBase(data: PersonsData.results)
            }
            .store(in: &cancellables)
        }
    
    func savePersonsInDataBase( data :[Result]?) -> Void {
        DbManager.shared.savePersonsInDataBase(data: data ?? []) {
            self.getUsersLocal()
            
        }
    }
    
    func getUsersLocal(){
        let  playerDataLocal =  DbManager.shared.fetchPerson()
        self.personList.removeAll()

        for playerItem in playerDataLocal {
            self.personList.append(playerItem)
        }
       //print("Local persion = \(personList)")
    }
}
