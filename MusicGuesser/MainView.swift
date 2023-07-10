//
//  MainView.swift
//  MusicGuesser
//
//  Created by Sean Erickson on 7/9/23.
//

import SwiftUI
import MusicKit

struct MainView: View {
    
    @State private var searchText = ""
    @State var songs = [Song]()
    
    private var request: MusicCatalogSearchRequest = {
        var request = MusicCatalogSearchRequest(term: "Fun", types: [Song.self])
        request.limit = 10
        return request
    }()
    
    private var selfRequest: MusicLibraryRequest = MusicLibraryRequest<Song>()
    
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    searchMusic()
                } label: {
                    Image(systemName: "play")
                }
                Spacer()
                TextField("Search", text: $searchText)
                    .onSubmit {
                        
                    }
                Spacer()
                
            }
            List(songs) { song in
                HStack {
                    Text(song.title)
                    Spacer()
                }
                
            }
        }
        
    }
    
    func searchMusic() {
        print("SEarching")
        Task {
            print("SEarching")
            let auth = await MusicAuthorization.request()
            switch auth {
            case .notDetermined:
                print("N/a")
            case .denied:
                print("denied")
            case .restricted:
                print("restricted")
            case .authorized:
                print("Authorized")
                do {
                    let result = try await selfRequest.response()
                    self.songs = Array(result.items)
                    //SystemMusicPlayer.ShuffleMode = .songs
                    let song = songs.randomElement()!
                    ApplicationMusicPlayer.shared.queue = [song]
                    try await ApplicationMusicPlayer.shared.prepareToPlay()
                    try await ApplicationMusicPlayer.shared.play()
                    
                    print(songs.randomElement()?.title ?? "N/A")
                } catch {
                    print(String(describing: error))
                }
            default:
                break
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
