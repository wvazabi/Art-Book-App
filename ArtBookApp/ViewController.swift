//
//  ViewController.swift
//  ArtBookApp
//
//  Created by Enes Kaya on 10.07.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var name = [String]()
    var id   = [UUID]()
    var selectingPaintingName = ""
    var selectingPaintingID : UUID?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        getData()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButton))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil)
        
    }
    
    @objc func getData(){
        name.removeAll(keepingCapacity: false)
        id.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            
            if results.count >  0 {
                for result in results as! [NSManagedObject]{
                if let name = result.value(forKey: "name") as? String{
                    self.name.append(name)
                }
                if let id = result.value(forKey: "id") as? UUID{
                    self.id.append(id)
                }
                
                self.tableView.reloadData()
            }
            }
        }catch{
            print("error")
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = name[indexPath.row]
                return cell
            
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
       }
    
       
    
    


    @objc func addButton(){
        selectingPaintingName = ""
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC"{
            let destinationVC = segue.destination as! DetailVC
            destinationVC.choosenPainting = selectingPaintingName
            destinationVC.choosenPaintingId = selectingPaintingID
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectingPaintingName = name[indexPath.row]
        selectingPaintingID = id[indexPath.row]
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
    
    
}

