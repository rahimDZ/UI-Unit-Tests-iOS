//
//  DashboardViewController.swift
//  UI-UnitTests-iOS
//
//  Created by Abderrahim BENMAKHLOUF on 21/01/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import UIKit

open class DashboardViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet fileprivate(set) weak var signInButton: UIButton?
    @IBOutlet fileprivate(set) weak var signUpButton: UIButton?
    
    // MARK: - Life Cycle

    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    // MARK: - Actions
    
    @IBAction func signUpDidTouchUpInside(_ sender: UIButton) {
        let signUpStoryboard = UIStoryboard(name: "SignUp", bundle: Bundle.main)
        if let signUpViewController = signUpStoryboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
            self.navigationController?.pushViewController(signUpViewController, animated: true)
        }
    }
}
