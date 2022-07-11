//
//  DetailVC.swift
//  ArtBookApp
//
//  Created by Enes Kaya on 10.07.2022.
//

import UIKit
import CoreData

class DetailVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var artistTF: UITextField!
    @IBOutlet weak var yearTF: UITextField!
    
    var choosenPainting : String = ""
    var choosenPaintingId : UUID?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if choosenPainting != ""{
            
        }
        else{
            nameTF.text = ""
            artistTF.text = ""
            yearTF.text = ""
        }
        
        
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        
        imageView.isUserInteractionEnabled = true
        
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(addPic))
        imageView.addGestureRecognizer(gestureRecognizer2)
        
    }
    @objc func addPic(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        
     
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let contex = appDelegate.persistentContainer.viewContext
        
        let newPaintings = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: contex)
        
        newPaintings.setValue(nameTF.text!, forKey: "name")
        newPaintings.setValue(artistTF.text!, forKey: "artist")
        
        newPaintings.setValue(UUID(), forKey: "id")
        
        if let year = Int(yearTF.text!){
            newPaintings.setValue(year, forKey: "year")
        }
        
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        
        newPaintings.setValue(data, forKey: "image")
        
        
        
        do{
            try contex.save()
            print("success")
        }catch{
            print("fail")
        }
        
        
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
