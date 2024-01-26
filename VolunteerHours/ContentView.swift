//
//  ContentView.swift
//  VolunteerHours
//
//  Created by Paul Inventado on 3/3/22.
//

import SwiftUI

// TODO: (Model 4) Copy new ContentView here
struct ContentView: View {
    @StateObject var manager = VolunteerManager()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("List of volunteers: ")
                    .font(.headline)
                    .padding(.bottom, 30)
                manager.volunteerList
                /*Text(manager.volunteerList)
                    .padding(.bottom, 30)*/
                NavigationLink(destination: VolunteerForm()) {
                    Text("Add more volunteers")
                        .bold()
                        .modifier(ButtonDesign())
                }
                Spacer()
            }
        }.environmentObject(manager)
    }
}


// TODO: (Model 4) Rename ContentView
struct VolunteerForm: View {
    @StateObject var volunteer = Volunteer(name: "", age: 0)
    @State var name: String = ""
    @State var age: String = ""
    @State var message: String = ""
    
    // TODO: (Model 4) Add EnvironmentObject
    @EnvironmentObject var manager: VolunteerManager
    
    var body: some View {
        // TODO: (Model 3) Surround the entire VStack with a NavigationView
        
        /* Model 3 start of code block */
        NavigationView{
            VStack {
                Text("Volunteer Form")
                    .font(.headline)
                VStack {
                    HStack {
                        Text("Name:")
                            .modifier(TextLabel())
                        TextField("Name", text: $name)
                            .modifier(TextBox())
                        Spacer()
                    }
                    HStack {
                        Text("Age:")
                            .modifier(TextLabel())
                        TextField("Age", text: $age)
                            .modifier(TextBox())
                        Spacer()
                    }
                }
                .modifier(RoundedBackground())
                .padding(.bottom, 30)
                
                HStack {
                    Button(action: {
                        if let validAge = Int(age) {
                            volunteer.name = name
                            volunteer.age = validAge
                            if volunteer.maxHours > 0 {
                                message = " is eligible to work up to \(volunteer.maxHours) hours."
                            } else {
                                message = "is not yet eligible to work."
                            }
                            
                        } else {
                            message = " does not have a valid age."
                        }
                    }){
                        Text("Validate")
                            .bold()
                            .modifier(RoundedBackground())
                            .foregroundColor(Color.white)
                    }
                }
                .padding(.bottom, 30)
                // TODO: (Model 3) Copy NavigationLink code here
                NavigationLink(destination: VolunteerDetails()) {
                    Text("See volunteer hour details.").font(.caption)
                }.padding(.bottom, 30)
                
                // TODO: (Model 2) Replace the whole code block below
                /* Model2 Start of code block */
                Report(message: $message, volunteer: volunteer)
                /* Model 2 End of code block */
                Spacer()
                // TODO: (Model 4) Insert Add Volunteer button code below
                HStack {
                    Button(action: {
                        if let validAge = Int(age), !name.isEmpty {
                            let newVolunteer = Volunteer(name: name, age: validAge)
                            manager.volunteers.append(newVolunteer)
                            message = "(\(newVolunteer.name) added!)"
                            name = ""
                            age = ""
                        } else {
                            message = "is not valid. Please add valid volunteer information."
                        }
                    }) {
                        Text("Add Volunteer")
                            .bold()
                            .modifier(ButtonDesign())
                    }
                }
                .padding(.bottom, 30)
            }
            /* Model 3 end of code block */
        }
    }
}

// TODO: (Model 2) Copy Report structure here
struct Report: View {
    @Binding var message: String
    @ObservedObject var volunteer: Volunteer
    
    var body: some View{
        VStack{
            HStack{
                // We can use if statement to control what view to display
                if !message.isEmpty{
                    Text("\(volunteer.name) (age \(volunteer.age))")
                    Text(message)
                }
            }
        }
    }
}

// TODO: (Model 3) Copy VolunteerDetails structure here
struct VolunteerDetails: View {
    // TODO: (Model 4) Insert Environment object here
    @EnvironmentObject var manager: VolunteerManager
    
    var body: some View {
        VStack {
            Text("Max hours given by age")
                .font(.headline)
                .padding(.bottom, 30)
            HStack {
                Text("Ages 13 - 17:")
                Text("4 hours").bold()
            }
            HStack {
                Text("Ages 18 - 50:")
                Text("6 hours").bold()
            }
            HStack {
                Text("Ages 51 - 60:")
                Text("3 hours").bold()
            }.padding(.bottom, 30)
            HStack {
                Text("*People below 13 and over 60 are not eligible to volunteer.")
                    .font(.caption)
            }
            Spacer()
            // TODO: (Model 4) Insert Text view here
            Text("There are currently \(manager.volunteers.count) volunteers.")
                            .padding(.bottom, 10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
