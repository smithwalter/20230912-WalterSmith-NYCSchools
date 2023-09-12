//
//  NYCSchoolDetailView.swift
//  20230912-WalterSmith-NYCSchools
//
//  Created by Walter Smith on 9/12/23.
//

import SwiftUI

protocol NYCSchoolDetailViewDelegate {
    func getDetails(forSchool:School) -> SchoolDetail?
}

// UI team will make pretty.
// TODO: make pretty

struct NYCSchoolDetailView: View {
    var delegate : NYCSchoolDetailViewDelegate
    var school : School
    var schoolDetail : SchoolDetail?
    init(_ delegate : NYCSchoolDetailViewDelegate,_ school : School) {
        self.delegate = delegate
        self.school = school
        
        schoolDetail = self.delegate.getDetails(forSchool: school)
    }
    

    var body : some View {
        VStack {
            if (schoolDetail != nil) {
                Text(school.school_name)
                    .font(.largeTitle)
                Text(school.location).font(.caption).fontWeight(.semibold)
                Text(school.phone_number).font(.caption).fontWeight(.semibold)
                Text("SAT data")
                    .font(.caption2)
                HStack {
                    Text("Students")
                    Text(schoolDetail!.num_of_sat_test_takers)
                }.font(.body)
                Text("Average Scores")
                    .font(.caption)
                HStack {
                    Text("Math")
                    Text(schoolDetail!.sat_math_avg_score)
                    Text("Writing")
                    Text(schoolDetail!.sat_writing_avg_score)
                    Text("Reading")
                    Text(schoolDetail!.sat_critical_reading_avg_score)
                }.font(.body)
                Text(school.overview_paragraph).padding()
            } else {
                Spacer()
                Text("We're sorry SAT data unavailable")
                Spacer()
            }
        }
    }
}
