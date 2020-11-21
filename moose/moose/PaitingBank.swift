//
//  PaintingsBank.swift
//  Moose
//
//  Created by Samuel Brasileiro on 17/11/20.
//

import Foundation
import UIKit
class Painting: ObservableObject, Identifiable{
    var name: String
    var description: String?
    var imageURL: String
    var artist: String?
    @Published var image: UIImage?
    
    init(name: String, description: String?, imageURL: String, people: [Person]?){
        self.name = name
        self.description = description
        self.imageURL = imageURL
        if people != nil{
            artist = people?.first?.displayname
        }
        else{
            artist = "Unknown Artist"
        }
        print(imageURL)
        getImage()
    }
    
    func getImage(){
        let request = URLRequest(url: URL(string: imageURL)!)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {
                    return
                }
                
                if let image = UIImage(data: data){
                    self.image = image
                }
            }
        }.resume()
    }
    
}

class PaintingsBank: ObservableObject, Identifiable{
    
    @Published var paintings: [Painting] = []
    
    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
    
    init(){
        PaintingsList.fetch{ result in
            if case .success(let list) = result{
                for record in list.records!{
                    if record.primaryimageurl == nil{
                        continue
                    }
                    self.paintings.append(Painting(name: record.title!, description: record.recordDescription, imageURL: record.primaryimageurl!, people: record.people))
                }
                
            }
        }
        
    }
    
}
