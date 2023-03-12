//
//  FollowerDetailView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 2/26/23.
//

import SwiftUI

struct FollowerDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var warbandVM: WarbandViewModel
    @ObservedObject var warband: Warband
    @ObservedObject var follower: Follower
    @State var isEditing: Bool = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Skill.name, ascending: true)],
        animation: .default)
    private var allSkills: FetchedResults<Skill>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Weapon.name, ascending: true)],
        animation: .default)
    private var allWeapons: FetchedResults<Weapon>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \EquipmentItem.name, ascending: true)],
        animation: .default)
    private var allItems: FetchedResults<EquipmentItem>
    
    var body: some View {
        VStack {
            ZStack {
                HeaderView(size: .medium, text: isEditing ? "Editing Follower..." : "Follower Details", widthPercentage: 0.5, height: 60)
                    .padding(.vertical)
                
                HStack {
                    Spacer()
                    Button {
                        isEditing.toggle()
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .padding(.trailing)
                            .foregroundColor(.accentColor)
                    }
                }
            }
            
            ScrollView {
                if isEditing {
                    EditFollowerView(warbandVM: warbandVM, follower: follower, isEditing: $isEditing)
                        .padding(.horizontal)
                } else {
                    CharacterDetailView(type: .follower, name: follower.name ?? "Unknown", origin: "None", agility: Int(follower.agility), speed: Int(follower.speed), dash: Int(follower.dashSpeed), combat: Int(follower.combatSkill), toughness: Int(follower.toughness), luck: Int(follower.luck), will: Int(follower.will), casting: 0, experience: 0)
                        .padding(.horizontal)
                }
                
                Group {
                    ZStack {
                        HeaderView(size: .medium, text: "Skills", widthPercentage: 0.5, height: 40)
                            .padding(.top)
                        HStack {
                            Spacer()
                            NavigationLink {
                                CreateFollowerSkillView(warbandVM: warbandVM, follower: follower)
                            } label: {
                                Image(systemName: "plus.circle")
                                    .foregroundColor(.accentColor)
                            }
                        }
                        .padding(.trailing)
                    }
                    
                    ForEach(allSkills, id: \.self) { skill in
                        if skill.ofFollower == follower, let skillName = skill.name {
                            HStack {
                                Text("• \(skillName)")
                                Spacer()
                                NavigationLink {
                                    SkillDetailView(warbandVM: warbandVM, skill: skill)
                                } label: {
                                    Image(systemName: "questionmark.circle.fill")
                                        .foregroundColor(.accentColor)
                                        .padding(.trailing)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 5)
                        }
                    }
                }
                
                Group {
                    ZStack {
                        HeaderView(size: .medium, text: "Equipment", widthPercentage: 0.5, height: 40)
                            .padding(.top)
                        HStack {
                            Spacer()
                            NavigationLink {
                                CreateItemView(warbandVM: warbandVM, placement: .follower, follower: follower)
                            } label: {
                                Image(systemName: "plus.circle")
                                    .foregroundColor(.accentColor)
                            }
                        }
                        .padding(.trailing)
                    }
                    
                    if let armor = follower.armor, let armorName = armor.name {
                        HStack {
                            Text("• \(armorName)")
                            Spacer()
                            NavigationLink {
                                ArmorDetailView(warbandVM: warbandVM, armor: armor, movingFrom: .follower, fromFollower: follower, warband: warband)
                            } label: {
                                Image(systemName: "questionmark.circle.fill")
                                    .foregroundColor(.accentColor)
                                    .padding(.trailing)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 5)
                    }
                    
                    ForEach(allWeapons, id: \.self) { weapon in
                        if weapon.ofFollower == follower, let weaponName = weapon.name {
                            HStack {
                                Text("• \(weaponName)")
                                Spacer()
                                NavigationLink {
                                    WeaponDetailView(warbandVM: warbandVM, weapon: weapon, movingFrom: .follower, fromFollower: follower, warband: warband)
                                } label: {
                                    Image(systemName: "questionmark.circle.fill")
                                        .foregroundColor(.accentColor)
                                        .padding(.trailing)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 5)
                        }
                    }
                    
                    ForEach(allItems, id: \.self) { item in
                        if item.ofFollower == follower, let itemName = item.name {
                            HStack {
                                Text("• \(itemName)")
                                Spacer()
                                NavigationLink {
                                    ItemDetailView(warbandVM: warbandVM, item: item, movingFrom: .follower, fromFollower: follower, warband: warband)
                                } label: {
                                    Image(systemName: "questionmark.circle.fill")
                                        .foregroundColor(.accentColor)
                                        .padding(.trailing)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 5)
                        }
                    }
                }
                
                CustomButton(text: "Promote to Hero", size: .medium, style: .active) {
                    warbandVM.promoteFollower(warband: warband, follower: follower)
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
            }
        }
    }
}

struct FollowerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let previewWarband = Warband(context: viewContext)
        previewWarband.name = "The Brightguard"
        let previewFollower = Follower(context: viewContext)
        previewFollower.name = "Guyver"
        
        return FollowerDetailView(warbandVM: WarbandViewModel(), warband: previewWarband, follower: previewFollower)
    }
}
