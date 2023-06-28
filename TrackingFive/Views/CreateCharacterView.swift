//
//  CreateCharacterView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 2/23/23.
//

import SwiftUI

struct CreateCharacterView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var warbandVM: WarbandViewModel
    @ObservedObject var warband: Warband
    @State var characterType: CharacterType = .hero
    @State var newCharacterName: String = ""
    @State var origin: String = ""
    @State var agility: Int = 1
    @State var speed: Int = 4
    @State var dash: Int = 3
    @State var combat: Int = 0
    @State var toughness: Int = 3
    @State var luck: Int = 0
    @State var will: Int = 0
    @State var casting: Int = 0
    
    var body: some View {
        VStack {
            HeaderView(size: .medium, text: "Create Character", widthPercentage: 0.5, height: 40)
                .padding(.top)
            
            ScrollView {
                Group {
                    HStack {
                        Text("Character Type: ")
                            .fontWeight(.bold)
                        Picker("Select character type", selection: $characterType) {
                            ForEach(CharacterType.allCases, id: \.self) { value in
                                Text(value.localizedName)
                                    .tag(value)
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Name: ")
                            .fontWeight(.bold)
                        TextField("\(characterType.rawValue) Name", text: $newCharacterName)
                            .disableAutocorrection(true)
                    }
                    .padding(.horizontal)
                    
                    if characterType == .hero {
                        HStack {
                            Text("Origin: ")
                                .fontWeight(.bold)
                            TextField("Hero Origin", text: $origin)
                                .disableAutocorrection(true)
                        }
                        .padding(.horizontal)
                    }
                    
                    HStack {
                        Text("Agility: ")
                            .fontWeight(.bold)
                        Picker("Agility", selection: $agility) {
                            ForEach(0 ..< 5, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Speed: ")
                            .fontWeight(.bold)
                        Picker("Speed", selection: $speed) {
                            ForEach(0 ..< 8, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        Text("/ +")
                        Picker("Dash", selection: $dash) {
                            ForEach(0 ..< 5, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Combat: ")
                            .fontWeight(.bold)
                        Picker("Combat", selection: $combat) {
                            ForEach(0 ..< 4, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Toughness: ")
                            .fontWeight(.bold)
                        Picker("Toughness", selection: $toughness) {
                            ForEach(0 ..< 7, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Luck: ")
                            .fontWeight(.bold)
                        Picker("Luck", selection: $luck) {
                            ForEach(0 ..< 7, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        
                        Text("Will: ")
                            .fontWeight(.bold)
                        Picker("Will", selection: $will) {
                            ForEach(0 ..< 7, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    if characterType == .hero {
                        HStack {
                            Text("Casting: ")
                                .fontWeight(.bold)
                            Picker("Casting", selection: $casting) {
                                ForEach(0 ..< 4, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    
                    Text("**Note:** You can add skills, spells, and/or equipment to this character after creation")
                        .padding()
                }
                
                HStack {
                    CustomButton(text: "Cancel", size: .medium, style: .cancel) {
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                    CustomButton(text: "Create", size: .medium, style: .active) {
                        warbandVM.createCharacter(warband: warband, type: characterType, name: newCharacterName, origin: origin, agility: agility, speed: speed, dash: dash, combat: combat, toughness: toughness, luck: luck, will: will, casting: casting)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
            }
            .padding(.horizontal)
            
        }
    }
}

struct CreateCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let previewWarband = Warband(context: viewContext)
        previewWarband.name = "The Brightguard"
        
        return CreateCharacterView(warbandVM: WarbandViewModel(), warband: previewWarband)
    }
}
