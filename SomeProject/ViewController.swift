//
//  ViewController.swift
//  SomeProject
//
//  Created by demothreen on 13/01/2019.
//  Copyright © 2019 demothreen. All rights reserved.
//

import UIKit

struct Photos: Codable {
    let albumId: Int?
    let id: Int?
    let title: String?
    let url: String?
    let thumbnailUrl: String?
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var imageItems: UICollectionView!
    
    var photos = [Photos]()
    let url = URL(string: "https://jsonplaceholder.typicode.com/photos")!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageItems.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as UICollectionViewCell
        
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageItems.delegate = self
        imageItems.dataSource = self
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            do{
                let decoder = JSONDecoder()
                self.photos = try decoder.decode([Photos].self, from: data)
                for photo in self.photos{
                    print(photo.url!)
                }
            }catch let err{
                print(err)
            }
//            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

