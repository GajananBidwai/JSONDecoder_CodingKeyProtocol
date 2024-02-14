//
//  ViewController.swift
//  JSONDecoder_CodingKeyProtocol
//
//  Created by Mac on 08/01/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var productTableView: UITableView!
    var product : [Product] = []
    var jsonDecoder : JSONDecoder?
    var productTableViewCell : ProductTableViewCell?
    override func viewDidLoad() {
        super.viewDidLoad()
      httpNetworkingByJsonDecoder()
        initializaTableView()
        
        registerXIBWithTableView()
        
        
    }
    func httpNetworkingByJsonDecoder()
    {
        let productUrl = URL(string: "https://fakestoreapi.com/products")
        var productUrlRequest = URLRequest(url: productUrl!)
        productUrlRequest.httpMethod = "GET"
        let productDataTask = URLSession.shared.dataTask(with: productUrlRequest) { productData, productResponse, productError in
            self.jsonDecoder = JSONDecoder()
           // self.product = try! JSONDecoder().decode([Product].self , from : productData!)
            
            self.product = try! JSONDecoder().decode([Product].self, from: productData!)
            
            print(self.product)
                
            DispatchQueue.main.async {
                self.productTableView.reloadData()
            }
        }
        productDataTask.resume()
        
    
    }
    func initializaTableView()
    {
        productTableView.dataSource = self
        productTableView.delegate = self
    }
    func registerXIBWithTableView()
    {
        let uinib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        productTableView.register(uinib, forCellReuseIdentifier: "ProductTableViewCell")
        
    }
}
extension ViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.5
    }
}
extension ViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        product.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        productTableViewCell = self.productTableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as! ProductTableViewCell
        
        productTableViewCell?.productNameLabel.text = product[indexPath.row].productName
        productTableViewCell?.rateLabel.text = String(product[indexPath.row].rate)
        productTableViewCell?.countLabel.text = String(product[indexPath.row].count)
        
        return productTableViewCell!
    }
}

