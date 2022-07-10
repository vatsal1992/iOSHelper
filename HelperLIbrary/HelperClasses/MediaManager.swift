//
//  MediaManager.swift
//  HelperLIbrary
//
//  Created by Vatsal Shukla on 10/07/22.
//

import UIKit
import Photos
protocol MediaSelectedDelegate: AnyObject {
    func selectedMediaType(image: UIImage)
    func permissionDenied()
}
class MediaManager: NSObject{
    private let imagePicker = UIImagePickerController()
    var allowsEditing: Bool = false
    var delegate: MediaSelectedDelegate?
    static let shared = MediaManager()
    override init(){}
    func showMediaSheetOn(_ viewController: UIViewController, allowsEditing: Bool = true) {
        imagePicker.allowsEditing = allowsEditing
        self.allowsEditing = allowsEditing
        
        let alert = UIAlertController(title: "Choose Image", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.capturePhotoFromCamera(viewController)     //self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.capturePhotoFromLibrary(viewController)
        }))
//        alert.addAction(UIAlertAction(title: "Delete Photo", style: .destructive, handler: {(action: UIAlertAction) in
//            Console.log("Delete Photo")
//            self.delegate?.deletedImage()
//            //self.requestServerDeleteProfile()
//        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
        
        
        //actionSheetController.view.tintColor = Constants.Color.appDefaultYellow
        //viewController.present(actionSheetController, animated: true, completion: nil)
    }
    private func capturePhotoFromCamera(_ viewController: UIViewController){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
                //already authorized
                showCamera(viewController)
                print("authorized")
            } else if AVCaptureDevice.authorizationStatus(for: .video) ==  .denied || AVCaptureDevice.authorizationStatus(for: .video) ==  .restricted{
                print("restricted denied")
                delegate?.permissionDenied()
            }else {
                AVCaptureDevice.requestAccess(for: .video, completionHandler: { [weak self](granted: Bool) in
                    if granted {
                        //access allowed
                        DispatchQueue.main.async {
                            self?.showCamera(viewController)
                        }
                        
                        print("request Access")
                        
                    } else {
                        print("request denied")
                        //access denied
                    }
                })
            }
            
        }else{
           // DisplayBanner.show(message: "No camera available.")
            print("No camera available.")
            //let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            
            
        }
        
        
    }
    private func showCamera(_ viewController: UIViewController){
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        viewController.present(imagePicker, animated: true, completion: nil)
    }
    private func capturePhotoFromLibrary(_ viewController:  UIViewController){
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        viewController.present(imagePicker, animated: true, completion: nil)
    }
}
extension MediaManager : UINavigationControllerDelegate{
    
}

extension MediaManager : UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            let key = self.allowsEditing ? UIImagePickerController.InfoKey.editedImage: UIImagePickerController.InfoKey.originalImage
            if let image = info[key] as? UIImage {
                self.delegate?.selectedMediaType(image: image)
            }
            
        }
        
    }
}
