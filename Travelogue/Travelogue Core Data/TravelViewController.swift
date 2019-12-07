//
//  TravelViewController.swift
//  Travelogue Core Data
//
//  Created by Henry Sills on 12/4/19.
//  Copyright © 2019 Dale Musser. All rights reserved.
//

import UIKit

class TravelViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var document: Document?
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = ""
        
        if let document = document {
            let name = document.name
            nameTextField.text = name
            contentTextView.text = document.content
            imageView.image = document.image
            title = name
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openCamera(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            alertNotifyUser(message: "Camera not available on simulator device")
            print("Camera not supported by this device")
            return
        }

        imagePicker.sourceType = .camera
        imagePicker.delegate = self

        present(imagePicker, animated: true)
    }
    
    @IBAction func openLibrary(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("can't open photo library")
            return
        }

        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self

        present(imagePicker, animated: true)
    }
    
    
    func alertNotifyUser(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func save(_ sender: Any) {
        guard let name = nameTextField.text else {
            alertNotifyUser(message: "Document not saved.\nThe name is not accessible.")
            return
        }
        
        let documentName = name.trimmingCharacters(in: .whitespaces)
        if (documentName == "") {
            alertNotifyUser(message: "Document not saved.\nA name is required.")
            return
        }
        
        let content = contentTextView.text!
        
        let image = imageView.image!
        
        if document == nil {
            // document doesn't exist, create new one
            document = Document(name: documentName, content: content, image: image)
        } else {
            // document exists, update existing one
            document?.update(name: documentName, content: content, image: image)
        }
        
        if let document = document {
            do {
                let managedContext = document.managedObjectContext
                try managedContext?.save()
            } catch {
                alertNotifyUser(message: "The document context could not be saved.")
            }
        } else {
            alertNotifyUser(message: "The document could not be created.")
        }
        
        navigationController?.popViewController(animated: true)
    }
    

    @IBAction func nameChanged(_ sender: Any) {
        title = nameTextField.text
    }
}



extension TravelViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        
        // get the image
        guard let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage else {
            return
        }

        // do something with it
        imageView.image = image
        
        defer {
            picker.dismiss(animated: true)
        }

        print(info)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        defer {
            picker.dismiss(animated: true)
        }

        print("did cancel")
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
