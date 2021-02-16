//
//  ViewController.swift
//  SandBoxDemo
//
//  Created by Sai Balaji on 16/02/21.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    var notes = [String]()
    
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "SandBoxDemo"
        
        print(NSHomeDirectory())
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(pickImage))
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addNote))
        
        
    }
    
    @objc
    func pickImage()
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
        
        
        
    }
    
    @objc
    func addNote()
    {
        let ac = UIAlertController(title: "Enter the note", message: nil, preferredStyle: .alert)
        
        ac.addTextField(configurationHandler: nil)
        
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
           
            if let enteredText = ac.textFields?.first?.text
            {
                self.notes.append(enteredText)
                self.SaveTextFile()
            }
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(ac, animated: true, completion: nil)
    }


}


extension ViewController
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage
        {
            imageView.image = image
            SaveImage(image: image)
        }
        
        dismiss(animated: true, completion: nil)
        
        
        
    }
    
    
    func SaveImage(image: UIImage)
    {
        
        var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let filename = "\(UUID().uuidString).jpg"
        
        path.appendPathComponent(filename)
        
        print(path.absoluteString)
        
        
        
        if let jpegImageData = image.jpegData(compressionQuality: 1.0)
        {
            do
            {
               try jpegImageData.write(to: path)
            }
            catch
            {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func SaveTextFile()
    {
        var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let filename = "notes.txt"
        
        path.appendPathComponent(filename)
        
        print(path.absoluteString)
        
        do
        {
            
                
            try self.notes.joined(separator: "\n").write(to: path, atomically: false, encoding: .utf8)
   
            
           
            
        }
        
        catch
        {
            print(error)
        }
    }
}


