//
//  ThreatLevelsView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 11/21/22.
//

import SwiftUI

struct ThreatLevelsView: View {
    @ObservedObject var warbandVM: WarbandViewModel
    @ObservedObject var warband: Warband
    @State var isShowingCreateThreatAlert: Bool = false
    @State var newThreatName: String = ""
    @State var threatNumber: ThreatNumber = .first
    @State var firstLevel: Int = 0
    @State var secondLevel: Int = 0
    @State var thirdLevel: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                if let threat = warband.firstThreat {
                    Stepper {
                        Text(threat.name ?? "First Threat")
                            .fontWeight(.bold)
                    } onIncrement: {
                        if firstLevel < 9 {
                            firstLevel += 1
                            warbandVM.increaseThreatLevel(threat: threat)
                        }
                    } onDecrement: {
                        if firstLevel > 0 {
                            firstLevel -= 1
                            warbandVM.decreaseThreatLevel(threat: threat)
                        }
                    }

                    ZStack {
                        Circle()
                            .foregroundColor(Color("LightGreen"))
                            .frame(maxWidth: 50)
                        Text("\(firstLevel)")
                            .fontWeight(.heavy)
                            .foregroundColor(Color("BlackWhite"))
                    }
                } else {
                    Text("Add a Threat")
                        .fontWeight(.bold)
                    Spacer()
                    Button {
                        threatNumber = .first
                        isShowingCreateThreatAlert.toggle()
                    } label: {
                        ZStack {
                            Circle()
                                .foregroundColor(.gray)
                                .frame(maxWidth: 50)
                            Text("+")
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            
            HStack {
                if let threat = warband.secondThreat {
                    Stepper {
                        Text(threat.name ?? "Second Threat")
                            .fontWeight(.bold)
                    } onIncrement: {
                        if secondLevel < 9 {
                            secondLevel += 1
                            warbandVM.increaseThreatLevel(threat: threat)
                        }
                    } onDecrement: {
                        if secondLevel > 0 {
                            secondLevel -= 1
                            warbandVM.decreaseThreatLevel(threat: threat)
                        }
                    }
                    
                    ZStack {
                        Circle()
                            .foregroundColor(Color("LightGreen"))
                            .frame(maxWidth: 50)
                        Text("\(secondLevel)")
                            .fontWeight(.heavy)
                            .foregroundColor(Color("BlackWhite"))
                    }
                } else {
                    Text("Add a Threat")
                        .fontWeight(.bold)
                    Spacer()
                    Button {
                        threatNumber = .second
                        isShowingCreateThreatAlert.toggle()
                    } label: {
                        ZStack {
                            Circle()
                                .foregroundColor(.gray)
                                .frame(maxWidth: 50)
                            Text("+")
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            
            HStack {
                if let threat = warband.thirdThreat {
                    Stepper {
                        Text(threat.name ?? "Third Threat")
                            .fontWeight(.bold)
                    } onIncrement: {
                        if thirdLevel < 9 {
                            thirdLevel += 1
                            warbandVM.increaseThreatLevel(threat: threat)
                        }
                    } onDecrement: {
                        if thirdLevel > 0 {
                            thirdLevel -= 1
                            warbandVM.decreaseThreatLevel(threat: threat)
                        }
                    }
                    
                    ZStack {
                        Circle()
                            .foregroundColor(Color("LightGreen"))
                            .frame(maxWidth: 50)
                        Text("\(thirdLevel)")
                            .fontWeight(.heavy)
                            .foregroundColor(Color("BlackWhite"))
                    }
                } else {
                    Text("Add a Threat")
                        .fontWeight(.bold)
                    Spacer()
                    Button {
                        threatNumber = .third
                        isShowingCreateThreatAlert.toggle()
                    } label: {
                        ZStack {
                            Circle()
                                .foregroundColor(.gray)
                                .frame(maxWidth: 50)
                            Text("+")
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
        .onAppear {
            firstLevel = Int(warband.firstThreat?.level ?? 0)
            secondLevel = Int(warband.secondThreat?.level ?? 0)
            thirdLevel = Int(warband.thirdThreat?.level ?? 0)
        }
        .alert("Create New Threat", isPresented: $isShowingCreateThreatAlert) {
            TextField("Threat Name", text: $newThreatName)
                .disableAutocorrection(true)
            Button("Create") {
                warbandVM.createThreat(name: newThreatName, number: threatNumber, warband: warband)
                newThreatName = ""
            }
            Button("Cancel", role: .cancel) {
                isShowingCreateThreatAlert.toggle()
                newThreatName = ""
            }
        } message: {
            Text("Enter the name of the new threat.")
        }
    }
}

struct ThreatLevelsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let previewWarband = Warband(context: viewContext)
        previewWarband.name = "The Brightguard"
        let newThreat = Threat(context: viewContext)
        newThreat.name = "The Ruin Within"
        newThreat.level = 5
        previewWarband.firstThreat = newThreat
        
        return ThreatLevelsView(warbandVM: WarbandViewModel(), warband: previewWarband)
    }
}
