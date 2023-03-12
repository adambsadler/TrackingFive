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
    @ObservedObject var warband: Warband
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
                HeaderView(size: .medium, text: isEditing ? "Editing Hero..." : "Hero Details", widthPercentage: 0.5, height: 60)
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
                    EditHeroView(warbandVM: warbandVM, hero: hero, isEditing: $isEditing)
                        .padding(.horizontal)
                } else {
                    CharacterDetailView(type: .hero, name: hero.name ?? "Unknown", origin: hero.origin ?? "Unknown", agility: Int(hero.agility), speed: Int(hero.speed), dash: Int(hero.dashSpeed), combat: Int(hero.combatSkill), toughness: Int(hero.toughness), luck: Int(hero.luck), will: Int(hero.will), casting: Int(hero.casting), experience: Int(hero.experience))
                        .padding(.horizontal)
                }
                
                Group {
                    ZStack {
                        HeaderView(size: .medium, text: "Skills", widthPercentage: 0.5, height: 40)
                            .padding(.top)
                        HStack {
                            Spacer()
                            NavigationLink {
                                CreateHeroSkillView(warbandVM: warbandVM, hero: hero)
                            } label: {
                                Image(systemName: "plus.circle")
                                    .foregroundColor(.accentColor)
                            }
                        }
                        .padding(.trailing)
                    }
                    
                    ForEach(allSkills, id: \.self) { skill in
                        if skill.ofHero == hero, let skillName = skill.name {
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
                    
                    ZStack {
                        HeaderView(size: .medium, text: "Spells", widthPercentage: 0.5, height: 40)
                            .padding(.top)
                        HStack {
                            Spacer()
                            NavigationLink {
                                CreateSpellView(warbandVM: warbandVM, hero: hero)
                            } label: {
                                Image(systemName: "plus.circle")
                                    .foregroundColor(.accentColor)
                            }
                        }
                        .padding(.trailing)
                    }
                    
                    
                    ForEach(allSpells, id: \.self) { spell in
                        if spell.ofHero == hero, let spellName = spell.name {
                            HStack {
                                Text("• \(spellName)")
                                Spacer()
                                NavigationLink {
                                    SpellDetailView(warbandVM: warbandVM, spell: spell)
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
                                CreateItemView(warbandVM: warbandVM, placement: .hero, hero: hero)
                            } label: {
                                Image(systemName: "plus.circle")
                                    .foregroundColor(.accentColor)
                            }
                        }
                        .padding(.trailing)
                    }
                    
                    if let armor = hero.armor, let armorName = armor.name {
                        HStack {
                            Text("• \(armorName)")
                            Spacer()
                            NavigationLink {
                                ArmorDetailView(warbandVM: warbandVM, armor: armor, movingFrom: .hero, fromHero: hero, warband: warband)
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
                        if weapon.ofHero == hero, let weaponName = weapon.name {
                            HStack {
                                Text("• \(weaponName)")
                                Spacer()
                                NavigationLink {
                                    WeaponDetailView(warbandVM: warbandVM, weapon: weapon, movingFrom: .hero, fromHero: hero, warband: warband)
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
                        if item.ofHero == hero, let itemName = item.name {
                            HStack {
                                Text("• \(itemName)")
                                Spacer()
                                NavigationLink {
                                    ItemDetailView(warbandVM: warbandVM, item: item, movingFrom: .hero, fromHero: hero, warband: warband)
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
            }
        }
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
        
        return HeroDetailView(warbandVM: WarbandViewModel(), warband: previewWarband, hero: previewHero)
    }
}
