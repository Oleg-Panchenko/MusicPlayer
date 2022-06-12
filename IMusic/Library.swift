//
//  Library.swift
//  IMusic
//
//  Created by Panchenko Oleg on 09.06.2022.
//

import SwiftUI
import URLImage

struct Library: View {
    
    @State var tracks = UserDefaults.standard.savedTracks()
    @State private var showingAlert = false
    @State private var track: SearchViewModel.Cell!
    
    var tabBarDelegate: MainTabBarControllerDelegate?
    
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geometry in
                    HStack(spacing: 20) {
                        Button {
                            print("12345")
                            self.track = self.tracks[0]
                            self.tabBarDelegate?.maximizeTrackDetailController(viewModel: self.track)
                        } label: {
                            Image(systemName: "play.fill")
                                .frame(width: geometry.size.width / 2 - 10 , height: 50)
                                .tint(Color(#colorLiteral(red: 1, green: 0.1719063818, blue: 0.4505617023, alpha: 1)))
                                .background(Color(#colorLiteral(red: 0.9632874131, green: 0.9632874131, blue: 0.9632874131, alpha: 1)))
                                .cornerRadius(10)
                        }
                        Button {
                            self.tracks = UserDefaults.standard.savedTracks()
                        } label: {
                            Image(systemName: "arrow.2.circlepath")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .tint(Color(#colorLiteral(red: 1, green: 0.1719063818, blue: 0.4505617023, alpha: 1)))
                                .background(Color(#colorLiteral(red: 0.9632874131, green: 0.9632874131, blue: 0.9632874131, alpha: 1)))
                                .cornerRadius(10)
                        } 
                    }
                }.padding().frame(height: 50)
                
                Divider().padding(.top).padding(.leading).padding(.trailing)
                List {
                    ForEach(tracks) { track in
                        LibraryCell(cell: track).gesture(
                            LongPressGesture()
                                .onEnded { _ in
                                    self.track = track
                                    self.showingAlert = true
                                }
                                .simultaneously(with: TapGesture()
                                    .onEnded { _ in
                                        let keyWindow = UIApplication.shared.connectedScenes.filter( {
                                            $0.activationState == .foregroundActive
                                        }).map({$0 as? UIWindowScene}).compactMap( {
                                            $0
                                        }).first?.windows.filter({$0.isKeyWindow}).first
                                        let tabBarVC = keyWindow?.rootViewController as? MainTabBarController
                                        tabBarVC?.trackDetailView.delegate = self
                                        
                                        self.track = track
                                        self.tabBarDelegate?.maximizeTrackDetailController(viewModel: self.track)
                                    }))
                    }
                    .onDelete(perform: delete)
                }
            }.actionSheet(isPresented: $showingAlert, content: {
                ActionSheet(title: Text("Are you sure you want to delete this track?"), buttons: [.destructive(Text("Delete"), action: {
                    self.delete(track: self.track)
                }),.cancel()
                ])
            })
            
            
            .navigationTitle("Library")
        }
        
    }
    
    func delete(at offsets: IndexSet) {
        tracks.remove(atOffsets: offsets)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
    
    func delete(track: SearchViewModel.Cell) {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return }
        tracks.remove(at: myIndex)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
}

struct LibraryCell: View {
    
    var cell: SearchViewModel.Cell
    
    var body: some View {
        HStack {
            URLImage(URL(string: cell.iconUrlString ?? "")!) { image in
                image
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(2)
            }
            VStack(alignment: .leading) {
                Text("\(cell.trackName)")
                Text("\(cell.artistName)")
            }
        }
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}

extension Library: TrackMovingDelegate {
    func moveBackForPreviousTrack() -> SearchViewModel.Cell? {
        
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return nil }
        var previousTrack: SearchViewModel.Cell
        if myIndex - 1 == -1 {
            previousTrack = tracks[tracks.count - 1]
        } else {
            previousTrack = tracks[myIndex - 1]
        }
        self.track = previousTrack
        return previousTrack
    }
    
    func moveForwardForNextTrack() -> SearchViewModel.Cell? {

        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return nil }
        var nextTrack: SearchViewModel.Cell
        if myIndex + 1 == tracks.count {
            nextTrack = tracks[0]
        } else {
            nextTrack = tracks[myIndex + 1]
        }
        self.track = nextTrack
        return nextTrack
    }
}
