//
//  SearchPresenter.swift
//  IMusic
//
//  Created by Panchenko Oleg on 31.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchPresentationLogic {
  func presentData(response: Search.Model.Response.ResponseType)
}

class SearchPresenter: SearchPresentationLogic {
  weak var viewController: SearchDisplayLogic?
  
  func presentData(response: Search.Model.Response.ResponseType) {
      
      switch response {
      case .presentTracks(let searchResults):
          let cells = searchResults?.results.map({ (track) in
              cellViewModel(from: track)
          }) ?? []
          let searchViewModel = SearchViewModel.init(cells: cells)
          print("presenter .presentTracks")
          viewController?.displayData(viewModel: Search.Model.ViewModel.ViewModelData.displayTracks(searchViewModel: searchViewModel))
      case .presentFooterView:
          viewController?.displayData(viewModel: Search.Model.ViewModel.ViewModelData.displayFooterView)
      }
  }
    
    private func cellViewModel(from track: Track) -> SearchViewModel.Cell {
        return SearchViewModel.Cell(iconUrlString: track.artworkUrl100,
                                    trackName: track.trackName,
                                    collectionName: track.collectionName ?? "",
                                    artistName: track.artistName,
                                    previewUrl: track.previewUrl)
    }
}
