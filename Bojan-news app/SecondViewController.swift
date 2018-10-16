//
//  SecondViewController.swift
//  Bojan-news app
//
//  Created by Josip Vukovic on 16/10/2018.
//  Copyright © 2018 Josip Vukovic. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    

    @IBOutlet weak var tekst: UILabel!
    @IBOutlet weak var naslov: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var article: Article?
    var naslov2 = String()
    var tekst2 = String()
    var image2 = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        naslov.text! = naslov2
        naslov.numberOfLines = 0
        naslov.sizeToFit()
        tekst.text! = tekst2
        tekst.numberOfLines = 0
        tekst .sizeToFit()
        //let url = URL(string: image2)
        image.downloadImage1(from: image2)

    }
    
}

extension UIImageView {
    
    func downloadImage1(from url: String)
    {
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest){ (data,response,error) in
            
            if error != nil{
                print(error!)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}

