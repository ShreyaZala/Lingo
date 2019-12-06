import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var translatedTextLabel: UILabel!
    
    @IBOutlet weak var languagePicker: UIPickerView!
    
    @IBOutlet weak var selectLanguageButtonOutlet: UIButton!
    
/*  -------------------------------------------------------------------------------------------------
    
    For camera & photo library access
     
    ---------------------------------------------------------------------------------------------------
 */
    
    
    
    let imagePicker = UIImagePickerController()
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPicKedImage = info[.originalImage] as? UIImage {
            
            imageView.image = userPicKedImage
            
        }
        
        guard CIImage(image: info[.originalImage] as! UIImage) != nil else {
            
            fatalError("Can't access the library.")
            
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func addPhotoButtonAdded(_ sender: UIBarButtonItem) {
        
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            
            fatalError("No image found!")
            
        }
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func cameraButtonTapped(_ sender: UIBarButtonItem) {
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            
            fatalError("Cannot access the camera!")
            
        }
        
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    
    /*  -------------------------------------------------------------------------------------------------
       
       To select a language
        
       ---------------------------------------------------------------------------------------------------
    */
    
    var picker = UIPickerView()
    
    var toolBar = UIToolbar()
    
    let languages: [String] = ["Select Language", "Hindi", "French", "Italian", "German", "Japanese"]
    
    @IBAction func selectLanguageButtonTapped(_ sender: UIButton) {
        
        
        
        picker = UIPickerView.init()
        picker.delegate = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)

        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(selectLanguageButtonTapped))]
        self.view.addSubview(toolBar)
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        
    }
    
    @objc func onDoneButtonTapped() {
        
        toolBar.removeFromSuperview()
        
        picker.removeFromSuperview()
        
    }
    
    
    /*  -------------------------------------------------------------------------------------------------
       
       Language Picker
        
       ---------------------------------------------------------------------------------------------------
    */
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return languages.count
        
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return languages[row]
        
    }

    private func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) -> String? {
        
        return languages[row]
        
    }
    
   
    
    /*  -------------------------------------------------------------------------------------------------
       
       viewDidLoad()
        
       ---------------------------------------------------------------------------------------------------
    */
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        imagePicker.delegate = self
                
        imagePicker.allowsEditing = false
        
        languagePicker.isHidden = false
        
        picker.delegate = self
        
        picker.dataSource = self
        
        let toolBar = UIToolbar()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneButtonClicked))
        
        toolBar.setItems([doneButton], animated: false)
        
    }
    
    @objc func doneButtonClicked() {
        
        view.endEditing(true)
        
    }

}

