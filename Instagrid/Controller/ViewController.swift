//
//  ViewController.swift
//  Instagrid
//
//  Created by laz on 01/06/2022.
//

import UIKit

enum Layout: Int {
    case layout1 = 1
    case layout2 = 2
    case layout3 = 3
}

final class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //Grid model
    var grid: Grid = Grid()
    
    //Grid view
    @IBOutlet weak var gridView: GridView!
    
    //Select layout
    @IBOutlet weak var selectLayoutStackView: SelectLayoutStackView!
    
    //Tag of image to add (+)
    private var selectedImageTag: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Swipe Up gesture recognize
        let swipeUpGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeUpGestureRecognizer.direction = .up
        gridView.addGestureRecognizer(swipeUpGestureRecognizer)
        
        //Swipe Left gesture recognize
        let swipeLeftGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeLeftGestureRecognizer.direction = .left
        gridView.addGestureRecognizer(swipeLeftGestureRecognizer)
        
        //Select default layout (layout 2)
        changeLayout(.layout2)
    }
    
    //Select layout
    @IBAction func selectLayout(_ sender: UIButton) {
        if let selectedLayoutView = sender.superview as? SelectLayoutView {
            switch selectedLayoutView.tag {
            case 1: changeLayout(.layout1)
            case 2: changeLayout(.layout2)
            case 3: changeLayout(.layout3)
            default: break
            }
        }
    }
    
    //Select layout function
    private func changeLayout(_ layout: Layout) {
        //Change layout
        grid.layout = layout
        
        //Display select icon on layout selected
        selectLayoutStackView.layout = layout
        
        //Change grid layout relative to layout selected
        gridView.layout = layout
    }
    
    //Add image in selected position
    @IBAction func addImageButtonTapped(_ sender: UIButton) {
        if let imagePickerView = sender.superview {
            selectedImageTag = imagePickerView.tag
            showImagePickerController()
        }
    }
    
    //Show image selection view
    private func showImagePickerController() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
    
    //Display selected image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let tag = selectedImageTag {
            if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                grid.images[tag] = image
                gridView.setImage(tag: tag, image: image)
            } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                gridView.setImage(tag: tag, image: image)
                grid.images[tag] = image
            }
        }
        
        dismiss(animated: true)
    }
    
    //On swipe function
    @objc func didSwipe(_ sender: UISwipeGestureRecognizer) {
        //Get interface orientation
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        let orientation = windowScene.interfaceOrientation
        
        var translationTransform: CGAffineTransform = .identity
        
        //Check if up or left swipe and interface orientation
        if orientation.isPortrait && sender.direction == .up {
            let superY = gridView.superview?.frame.origin.y ?? 0
            translationTransform = CGAffineTransform(translationX: 0, y: -(gridView.frame.origin.y + superY + gridView.frame.height))
        } else if orientation.isLandscape && sender.direction == .left {
            let superHeight = gridView.superview?.frame.height ?? 0
            translationTransform = CGAffineTransform(translationX: -(gridView.frame.origin.x + superHeight + gridView.frame.width), y: 0)
        } else { return }
        
//        view.intrinsicContentSize.
        
        //Animate grid view according to swipe direction and interface orientation
        UIView.animate(withDuration: 0.3) {
            self.gridView.transform = translationTransform
        }
        
        if grid.isComplete {
            shareGrid()
        } else {
            UIView.animate(withDuration: 0.3) {
                self.gridView.transform = .identity
            }
            
            let alertView = UIAlertController(title: "Instagrid", message: "Add images to your grid !", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alertView, animated: true)
        }
    }
    
    private func shareGrid() {
        let activityView = UIActivityViewController(activityItems: ["Share Instagrid creation", gridView.image], applicationActivities: nil)
        activityView.isModalInPresentation = true
        
        activityView.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed: Bool, arrayReturnedItems: [Any]?, error: Error?) in
            
            UIView.animate(withDuration: 0.3) {
                self.gridView.transform = .identity
            }
            
            if completed {
                print("share completed")
                return
            } else {
                print("cancel")
            }
            if let shareError = error {
                print("error while sharing: \(shareError.localizedDescription)")
            }
        }
        
        self.present(activityView, animated: true)
    }
    
}
