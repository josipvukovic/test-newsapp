//
//  ViewController.swift
//  Bojan-news app
//
//  Created by Josip Vukovic on 16/10/2018.
//  Copyright © 2018 Josip Vukovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    let cellId = "feedCell"
    @IBOutlet weak var tableview: UITableView!
    var articles: [Article]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchJsonData()
    }
    
    func fetchJsonData() {
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v2/top-headlines?sources=bbc-sport&apiKey=1463a90247aa4affb624e424c38ca35c")!)
    
    let task = URLSession.shared.dataTask(with: urlRequest){(data,response,error) in
        if error != nil
        {
            print(error!)
            return
        }
        
        self.articles = [Article]()
        do
        {
            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
            
            if let articlesJson = json["articles"] as? [[String : AnyObject]]{
                for articleJson in articlesJson{
                    let article = Article()
                    if let title = articleJson["title"] as? String,let desc = articleJson["description"] as? String,let slika = articleJson["urlToImage"] as? String,let datum = articleJson["publishedAt"] as? String  {
                        article.title = title
                        article.desc = desc
                        article.slika  = slika
                        article.datum = datum
                        print(title)
                        
                    }
                    self.articles?.append(article)
                }
                
            }
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
            
            }catch let error
        {
            print(error)
        }
        
    }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView : UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId,for:indexPath) as! FeedCell
        
        cell.title.text = self.articles?[indexPath.item].title
        cell.desc.text = self.articles?[indexPath.item].desc
        cell.slika.downloadImage(from: (self.articles?[indexPath.item].slika!)!)
        cell.datum.text = self.articles?[indexPath.item].datum
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Storyboard = UIStoryboard(name: "Main",bundle: nil )
        let DvC = Storyboard.instantiateViewController(withIdentifier: "secondViewController") as! SecondViewController
        
        DvC.tekst2 = articles![indexPath.row].desc!
        DvC.naslov2 = articles![indexPath.row].title!
        DvC.image2 = articles![indexPath.row].slika!
        
        //self.present(DvC, animated:true, completion:nil)
        self.navigationController?.pushViewController(DvC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}



extension UIImageView {
    
    func downloadImage(from url: String)
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










