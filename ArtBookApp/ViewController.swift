//
//  ViewController.swift
//  ArtBookApp
//
//  Created by Enes Kaya on 10.07.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButton))
    }


    @objc func addButton(){
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
}

