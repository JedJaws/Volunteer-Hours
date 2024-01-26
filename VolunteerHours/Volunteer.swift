//
//  Volunteer.swift
//  VolunteerHours
//
//  Created by Paul Inventado on 3/3/22.
//

import Foundation
import UIKit
import SwiftUI

class Volunteer: ObservableObject, Identifiable {
    @Published var name: String
    @Published var age: Int
    
    var maxHours: Int {
        switch age {
            case 13...17: return 4
            case 18...50: return 6
            case 51...60: return 3
            default: return 0
        }
    }
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

// TODO: (Model 4) Copy VolunteerManager here
class VolunteerManager: ObservableObject {
    @Published var volunteers: [Volunteer] = []
    
    /*var volunteerList: String {
        var list: String = ""
        if !volunteers.isEmpty {
            for volunteer in volunteers {
                list += volunteer.name + " "
            }
        } else {
            list = ""
        }
        return list
    }*/
    
    var volunteerList: some View{
        VStack{
            ForEach(volunteers) {
                volunteers in
                HStack {
                    Text("😊")
                        .frame(width: 50)
                        .padding(.leading, 20)
                    Text("\(volunteers.name) (\(volunteers.age))")
                    Spacer()
                }
                .padding(.bottom, 20)
            }
        }
    }


    
    func volunteer(_ volunteer: Volunteer){
        let newCopy = Volunteer(name: volunteer.name, age: volunteer.age)
        volunteers.append(newCopy)
    }
    
    init() {
        
    }
    
}
