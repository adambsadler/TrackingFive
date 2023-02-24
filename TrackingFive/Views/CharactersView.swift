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
            HStack {
                Text("Characters")
                    .font(.headline)
                    .fontWeight(.heavy)
                    .padding(.top)
                Spacer()
                NavigationLink {
                    CreateCharacterView(warbandVM: warbandVM, warband: warband)
                } label: {
                    Image(systemName: "plus.circle")
                        .foregroundColor(.accentColor)
                }
            }
            
            Divider()
            
            ForEach(warbandVM.heroes, id: \.self) { hero in
                if let currentHero = hero {
                    NavigationLink {
                        HeroDetailView(warbandVM: warbandVM, hero: hero)
                    } label: {
                        CharacterListView(name: currentHero.name ?? "Unknown", type: .hero, agility: Int(currentHero.agility), speed: Int(currentHero.speed), dash: Int(currentHero.dashSpeed), combat: Int(currentHero.combatSkill), toughness: Int(currentHero.toughness))
                    }
                }
            }
            
            ForEach(warbandVM.followers, id: \.self) { follower in
                if let currentFollower = follower {
                    CharacterListView(name: currentFollower.name ?? "Unknown", type: .follower, agility: Int(currentFollower.agility), speed: Int(currentFollower.speed), dash: Int(currentFollower.dashSpeed), combat: Int(currentFollower.combatSkill), toughness: Int(currentFollower.toughness))
                }
            }
            
        }
        .padding(.horizontal)
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
