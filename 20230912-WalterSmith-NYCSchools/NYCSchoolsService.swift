//
//  NYCSchoolsService.swift
//  20230912-WalterSmith-NYCSchools
//
//  Created by Walter Smith on 9/12/23.
//

import Foundation
import UIKit
import Combine

protocol NYCSchoolsServiceDelegate {
    func SchoolsListUpdated(_ schools: [School])
    func SchoolDetailsUpdated(_ schools: [SchoolDetail])
}

class NYCSchoolsService {
    var schools : [School]?
    var delegate : NYCSchoolsServiceDelegate?
    var cancellables = Set<AnyCancellable>()

    func getSchools() {
        guard let url = URL(string:"https://data.cityofnewyork.us/resource/s3k6-pzi2.json") else {return}
        URLSession
            .shared
            .dataTaskPublisher(for: url)
            .tryMap() { element->Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                (200...299) ~= httpResponse.statusCode else {throw URLError(.badServerResponse)}
                return element.data
            }.decode(type: [School].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
             .sink(
                receiveCompletion: { print("\($0)")},
                receiveValue: {[weak self] schoolDetails in
                self?.delegate?.SchoolsListUpdated(schoolDetails)
                }
             ).store(in: &cancellables)
    }
    
    func getSchoolDetails() {
        guard let url = URL(string:"https://data.cityofnewyork.us/resource/f9bf-2cp4.json") else {return}
        URLSession
            .shared
            .dataTaskPublisher(for: url)
            .tryMap() { element->Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      (200...299) ~= httpResponse.statusCode else {throw URLError(.badServerResponse)}
                return element.data
            }.decode(type: [SchoolDetail].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
             .sink(
                receiveCompletion: { print("\($0)")},
                receiveValue: {[weak self] schoolDetails in
                    self?.delegate?.SchoolDetailsUpdated(schoolDetails)
                    
                }
             ).store(in: &cancellables)
    }
}

