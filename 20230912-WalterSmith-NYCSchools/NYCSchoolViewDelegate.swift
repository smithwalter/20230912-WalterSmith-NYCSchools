//
//  NYCSchoolViewDelegate.swift
//  20230912-WalterSmith-NYCSchools
//
//  Created by Walter Smith on 9/12/23.
//
import Foundation

class NYCSchoolViewDelegate : NSObject,
                                      ObservableObject,
                                      NYCSchoolsServiceDelegate,
                                      NYCSchoolDetailViewDelegate {
    

    // This data doesn't change much
    @Published var schools : [School]?
    @Published var schoolDetails : [SchoolDetail]?
    
    var _schoolService : NYCSchoolsService
    
    func SchoolDetailsUpdated(_ schoolDetails: [SchoolDetail]) {
        self.schoolDetails = schoolDetails
    }
    
    // Sorting by name.
    func SchoolsListUpdated(_ schools: [School]) {
        self.schools = schools.sorted(by: {$0.school_name < $1.school_name})
    }
    
    // Using a filter to search an array.
    func getDetails(forSchool : School) -> SchoolDetail? {
        let details = schoolDetails?.filter({$0.dbn == forSchool.dbn})
        return details?.count ?? -1 > 0 ? details?[0] : nil
    }
    
    override init() {
        self.schools = [School]()
        self.schoolDetails = [SchoolDetail]()
        self._schoolService = NYCSchoolsService()
        
        super.init()
        
        // Data doesn't change much, so updating on app load should be enough
        _schoolService.delegate = self
        _schoolService.getSchools()
        _schoolService.getSchoolDetails()
    }
}
