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
                if let currentHero = hero {
                    NavigationLink {
                        HeroDetailView(warbandVM: warbandVM, warband: warband, hero: hero)
                    } label: {
                        CharacterListView(name: currentHero.name ?? "Unknown", type: .hero, agility: Int(currentHero.agility), speed: Int(currentHero.speed), dash: Int(currentHero.dashSpeed), combat: Int(currentHero.combatSkill), toughness: Int(currentHero.toughness))
                            .padding(.horizontal)
                    }
                }
            }
            
            ForEach(warbandVM.followers, id: \.self) { follower in
                if let currentFollower = follower {
                    NavigationLink {
                        FollowerDetailView(warbandVM: warbandVM, warband: warband, follower: follower)
                    } label: {
                        CharacterListView(name: currentFollower.name ?? "Unknown", type: .follower, agility: Int(currentFollower.agility), speed: Int(currentFollower.speed), dash: Int(currentFollower.dashSpeed), combat: Int(currentFollower.combatSkill), toughness: Int(currentFollower.toughness))
                            .padding(.horizontal)
                    }
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
