//
//  HeroDetailView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 2/24/23.
//

import SwiftUI

struct HeroDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var warbandVM: WarbandViewModel
    @ObservedObject var hero: Hero
    @State var isEditing: Bool = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Skill.name, ascending: true)],
        animation: .default)
    private var allSkills: FetchedResults<Skill>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Spell.name, ascending: true)],
        animation: .default)
    private var allSpells: FetchedResults<Spell>
    
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
                Text(isEditing ? "Editing Hero..." : "Hero Details")
                    .font(.headline)
                
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
                    EditHeroView(warbandVM: warbandVM, hero: hero, isEditing: $isEditing)
                } else {
                    CharacterDetailView(type: .hero, name: hero.name ?? "Unknown", origin: hero.origin ?? "Unknown", agility: Int(hero.agility), speed: Int(hero.speed), dash: Int(hero.dashSpeed), combat: Int(hero.combatSkill), toughness: Int(hero.toughness), luck: Int(hero.luck), will: Int(hero.will), casting: Int(hero.casting), experience: Int(hero.experience))
                }
                
                Group {
                    HStack {
                        Text("Skills")
                            .font(.headline)
                            .fontWeight(.heavy)
                            .padding(.top)
                        Spacer()
                        NavigationLink {
                            CreateHeroSkillView(warbandVM: warbandVM, hero: hero)
                        } label: {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.accentColor)
                        }
                    }
                    
                    Divider()
                    
                    ForEach(allSkills, id: \.self) { skill in
                        if skill.ofHero == hero, let skillName = skill.name {
                            HStack {
                                Text("• \(skillName)")
                                Spacer()
                                NavigationLink {
                                    // skill detail view
                                } label: {
                                    Image(systemName: "questionmark.circle.fill")
                                        .foregroundColor(.accentColor)
                                        .padding(.trailing)
                                }
                            }
                            .padding(.bottom, 5)
                        }
                    }
                    
                    HStack {
                        Text("Spells")
                            .font(.headline)
                            .fontWeight(.heavy)
                            .padding(.top)
                        Spacer()
                        NavigationLink {
                            // Create spell
                        } label: {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.accentColor)
                        }
                    }
                    
                    Divider()
                    
                    ForEach(allSpells, id: \.self) { spell in
                        if spell.ofHero == hero, let spellName = spell.name {
                            HStack {
                                Text("• \(spellName)")
                                Spacer()
                                NavigationLink {
                                    // spell detail view
                                } label: {
                                    Image(systemName: "questionmark.circle.fill")
                                        .foregroundColor(.accentColor)
                                        .padding(.trailing)
                                }
                            }
                            .padding(.bottom, 5)
                        }
                    }
                    
                    
                }
                .padding(.horizontal)
                
                Group {
                    HStack {
                        Text("Equipment")
                            .font(.headline)
                            .fontWeight(.heavy)
                            .padding(.top)
                        Spacer()
                        NavigationLink {
                            CreateItemView(warbandVM: warbandVM, placement: .hero, hero: hero)
                        } label: {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.accentColor)
                        }
                    }
                    
                    Divider()
                    
                    if let armor = hero.armor, let armorName = armor.name {
                        HStack {
                            Text("• \(armorName)")
                            Spacer()
                            NavigationLink {
                                // armor detail view
                            } label: {
                                Image(systemName: "questionmark.circle.fill")
                                    .foregroundColor(.accentColor)
                                    .padding(.trailing)
                            }
                        }
                        .padding(.bottom, 5)
                    }
                    
                    ForEach(allWeapons, id: \.self) { weapon in
                        if weapon.ofHero == hero, let weaponName = weapon.name {
                            HStack {
                                Text("• \(weaponName)")
                                Spacer()
                                NavigationLink {
                                    // weapon detail view
                                } label: {
                                    Image(systemName: "questionmark.circle.fill")
                                        .foregroundColor(.accentColor)
                                        .padding(.trailing)
                                }
                            }
                            .padding(.bottom, 5)
                        }
                    }
                    
                    ForEach(allItems, id: \.self) { item in
                        if item.ofHero == hero, let itemName = item.name {
                            HStack {
                                Text("• \(itemName)")
                                Spacer()
                                NavigationLink {
                                    // item detail view
                                } label: {
                                    Image(systemName: "questionmark.circle.fill")
                                        .foregroundColor(.accentColor)
                                        .padding(.trailing)
                                }
                            }
                            .padding(.bottom, 5)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
        }
        .padding()
    }
}

struct HeroDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let previewWarband = Warband(context: viewContext)
        previewWarband.name = "The Brightguard"
        let previewHero = Hero(context: viewContext)
        previewHero.name = "Valten"
        previewHero.origin = "Human"
        
        return HeroDetailView(warbandVM: WarbandViewModel(), hero: previewHero)
    }
}
