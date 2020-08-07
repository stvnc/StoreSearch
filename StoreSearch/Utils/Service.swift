//
//  Service.swift
//  StoreSearch
//
//  Created by Vincent Angelo on 06/08/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Foundation
import UIKit

class Service {
    static func iTunesURL(searchText: String) -> URL {
        // Changing space to %20 with built in encoding
        let encodedText = searchText.addingPercentEncoding(
        withAllowedCharacters: CharacterSet.urlQueryAllowed)!
      let urlString = String(format:
          "https://itunes.apple.com/search?term=%@", encodedText)
      let url = URL(string: urlString)
      return url!
    }
    
    static func performStoreRequest(with url: URL) -> Data? {
      do {
       return try Data(contentsOf:url)
      } catch {
       print("Download Error: \(error.localizedDescription)")
       return nil
      }
    }
    
    static func parse(data: Data) -> [SearchResult] {
      do {
        let decoder = JSONDecoder()
        let result = try decoder.decode(ResultArray.self, from:data)
        return result.results
      } catch {
        print("JSON Error: \(error)")
        return []
      }
    }
    
    static func showNetworkError() -> UIAlertController{
        let alert = UIAlertController(title: "WHoops!", message: "There was an error accessing the iTunes store, please try again!.", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        return alert
    }
}
