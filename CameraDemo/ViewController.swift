//
//  ViewController.swift
//  CameraDemo
//
//  Created by icrdcyy on 2018/1/24.
//  Copyright © 2018年 yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

   
    @IBOutlet weak var secretLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var previewView: UIView!
    
    var imagePicker : UIImagePickerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
       
    }
    
    
    @IBAction func takeCamera(_ sender: UIButton) {
        showCamera()
    }
    
    func showCamera(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            imagePicker = UIImagePickerController()
            imagePicker?.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker?.delegate = self
            imagePicker?.showsCameraControls = false
            
            
            let controllerHeight = UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.width * 1.3333
            
//            let myYellowCameraBtn = UIButton(
//                frame:CGRectMake(UIScreen.main.bounds.size.width/2 - 95/2, controllerHeight/2 - 95/2,95,95)

            let myYellowCameraBtn = UIButton(
                frame:CGRect(origin:CGPoint(x:UIScreen.main.bounds.size.width/2 - 95/2, y: UIScreen.main.bounds.size.height -  95 - 95/2), size:CGSize(width:95,height:95))
            )
            
            myYellowCameraBtn.setImage(UIImage(named:"take"), for: .normal)
            
            myYellowCameraBtn.addTarget(self, action: #selector(ViewController.snap), for: .touchUpInside)
            
            imagePicker?.view.addSubview(myYellowCameraBtn)
            
            if imagePicker != nil {
                self.present(imagePicker!,animated:true,completion: nil)
            }else{
                print("imagepicker is nil")
            }
            
            
            
            
        }else{
            let alert = UIAlertController(title: "Info", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @objc func snap(){
        imagePicker?.takePicture()
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let theImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        
      
        self.dismiss(animated: true, completion: nil)
        
        imageView.image = theImage
        secretLabel.text = ""
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func saveBtnAction(_ sender: UIButton) {
        
        if imageView.image != nil {
//            var theImg :UIImage
//            theImg = imageView.image!
            
            
            // add label to image
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.dd.MM hh:mm:ss "
            let currentDate = formatter.string(from: date)
            
        secretLabel.text = "Secret Secret Secret.\n \(currentDate)"
            
        UIGraphicsBeginImageContextWithOptions(previewView.bounds.size, true, 0.0)
        previewView.drawHierarchy(in: previewView.bounds,afterScreenUpdates:true)
            let addTextImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            UIImageWriteToSavedPhotosAlbum(addTextImage, nil, nil, nil)
            
            
            let alert = UIAlertController(title: "Info", message: "save photo completion", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func savePhotoCompletionAction(){
        
       
    }
}

