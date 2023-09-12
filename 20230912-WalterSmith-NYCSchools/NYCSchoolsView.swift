//
//  ContentView.swift
//  20230912-WalterSmith-NYCSchools
//
//  Created by Walter Smith on 9/12/23.
//

import SwiftUI

struct NYCSchoolsView: View {
    @ObservedObject var delegate = NYCSchoolViewDelegate()
    var body: some View {
        NavigationStack {
            VStack {
                Text("NYC Schools")
                Text("(click for details)")
                if (delegate.schools != nil) {
                    List(delegate.schools!) { school in
                        NavigationLink(school.school_name, destination: NYCSchoolDetailView(delegate,school) )
                    }
                } else {
                    Spacer()
                    Text("no data yet")
                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NYCSchoolsView()
    }
}
