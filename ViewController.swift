//
//  ViewController.swift
//  Networking
//
//  Created by Mafe Trochez on 2/11/2022.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var downloadImageButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = ""
        nameLabel.numberOfLines = 0
        emailLabel.text = ""
        emailLabel.numberOfLines = 0
        idLabel.text = ""
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
    }

    @IBAction func getUserAction(_ sender: Any) {
        
        activityIndicator.startAnimating()
        
        NetworkingProvider.shared.getUser(id: 1828) { (user) in
            
            self.activityIndicator.stopAnimating()
            
            self.setup(user: user)
            
        } failure: { (error) in
            
            self.activityIndicator.stopAnimating()
            
            self.nameLabel.text = error.debugDescription
        }

    }
    
    @IBAction func addUserAction(_ sender: Any) {
        
        let newUser = NewUser(name: "Maria Fernanda", email: "neomafe1416@gmailcom", gender: "Femenine", status: "Active")
        
        activityIndicator.startAnimating()
        
        NetworkingProvider.shared.addUser(user: newUser) { (user) in
            
            self.activityIndicator.stopAnimating()
            
            self.setup(user: user)
            
        } failure: { (error) in
            
            self.activityIndicator.stopAnimating()
            
            self.nameLabel.text = error.debugDescription
        }

    }
    
    @IBAction func updateUserAction(_ sender: Any) {
        
        let newUser = NewUser(name: "Hanny Potter", email: nil, gender: nil, status: nil)
        
        activityIndicator.startAnimating()
        
        NetworkingProvider.shared.updateUser(id: 1828, user: newUser) { (user) in
            
            self.activityIndicator.stopAnimating()
            
            self.setup(user: user)
            
        } failure: { (error) in
            
            self.activityIndicator.stopAnimating()
            
            self.nameLabel.text = error.debugDescription
        }
    }
    
    @IBAction func deleteUserAction(_ sender: Any) {
        
        activityIndicator.startAnimating()
        
        let id = 1828
        
        NetworkingProvider.shared.deleteUser(id: id) {
            
            self.activityIndicator.stopAnimating()
            
            self.nameLabel.text = "Se ha borrado el usuario con ID: \(id)"
            self.emailLabel.text = ""
            self.idLabel.text = ""
            
        } failure: { (error) in
            
            self.activityIndicator.stopAnimating()
            
            self.nameLabel.text = error.debugDescription
        }

    }
    
    @IBAction func downloadImageAction(_ sender: Any) {
        
        downloadImageButton.isHidden = true
        logoImageView.kf.setImage(with: URL(string: "https://drive.google.com/file/d/1yxlRAFdtjD_aq5G_FiKwI1sx4cfkUQfU/view"))
    }
    
    private func setup(user: User) {
        
        nameLabel.text = user.name
        emailLabel.text = user.email
        idLabel.text = user.id?.description
    }
    
}

