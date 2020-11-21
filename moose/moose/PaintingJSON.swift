//
//  Painting.swift
//  Moose
//
//  Created by Samuel Brasileiro on 17/11/20.
//

import Foundation

// MARK: - PaintingsList

class PaintingsList: Codable {
    let info: Info?
    let records: [Record]?

    init(info: Info?, records: [Record]?) {
        self.info = info
        self.records = records
    }
    
    class func fetch(completion: @escaping (Result<PaintingsList,Error>) -> Void){
        
        let url = URL(string: "https://api.harvardartmuseums.org/object?apikey=8afbb89f-955f-487a-b34d-b19ad492e27e&classification=26&sort=random&hasimage=1")!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            do {
                let list = try JSONDecoder().decode(PaintingsList.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(list))
                }
                
                
            } catch let error {
                print(error)
                completion(.failure(error))
            }
        }.resume()
    }
    
}

// MARK: - Info
class Info: Codable {
    let totalrecordsperquery, totalrecords, pages, page: Int?
    let next: String?

    init(totalrecordsperquery: Int?, totalrecords: Int?, pages: Int?, page: Int?, next: String?) {
        self.totalrecordsperquery = totalrecordsperquery
        self.totalrecords = totalrecords
        self.pages = pages
        self.page = page
        self.next = next
    }
}

// MARK: - Record
class Record: Codable {
    
    //let images: [ImageItem]?
    
    let primaryimageurl: String?
    
    let recordDescription: String?
    
    let title: String?
    
    let people: [Person]?
    
    enum CodingKeys: String, CodingKey {
        case primaryimageurl
        case recordDescription = "description"
        case title, people
    }

    init(primaryimageurl: String?, recordDescription: String?, title: String, people: [Person]?) {
        
        self.primaryimageurl = primaryimageurl
        
        self.recordDescription = recordDescription
        
        self.title = title
        
        self.people = people
        
    }
}



// MARK: - Person
class Person: Codable {
    let culture, displayname, name: String?

    init(culture: String?, displayname: String?, name: String?) {

        self.culture = culture
        self.displayname = displayname
        self.name = name
    }
}

