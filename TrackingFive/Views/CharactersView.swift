//
//  CharactersView.swift
//  TrackingFive
//
//  Created by Adam Sadler on 2/23/23.
//

import SwiftUI

struct CharactersView: View {
    @ObservedObject var warbandVM: WarbandViewModel
    @ObservedObject var warband: Warband
    
    var body: some View {
        VStack {
            ZStack {
                HeaderView(size: .medium, text: "Characters", widthPercentage: 0.5, height: 40)
                    .padding(.top)
                HStack {
                    Spacer()
                    NavigationLink {
                        CreateCharacterView(warbandVM: warbandVM, warband: warband)
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
                .padding(.trailing)
            }
            
            ForEach(warbandVM.heroes, id: \.self) { hero in
                NavigationLink {
                    HeroDetailView(warbandVM: warbandVM, warband: warband, hero: hero)
                } label: {
                    CharacterListView(name: hero.name ?? "Unknown", type: .hero, agility: Int(hero.agility), speed: Int(hero.speed), dash: Int(hero.dashSpeed), combat: Int(hero.combatSkill), toughness: Int(hero.toughness))
                        .padding(.horizontal)
                }
            }
            
            ForEach(warbandVM.followers, id: \.self) { follower in
                NavigationLink {
                    FollowerDetailView(warbandVM: warbandVM, warband: warband, follower: follower)
                } label: {
                    CharacterListView(name: follower.name ?? "Unknown", type: .follower, agility: Int(follower.agility), speed: Int(follower.speed), dash: Int(follower.dashSpeed), combat: Int(follower.combatSkill), toughness: Int(follower.toughness))
                        .padding(.horizontal)
                }
            }
            
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let previewWarband = Warband(context: viewContext)
        previewWarband.name = "The Brightguard"
        
        return CharactersView(warbandVM: WarbandViewModel(), warband: previewWarband)
    }
}
