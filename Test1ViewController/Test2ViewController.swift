//
//  Test2ViewController.swift
//  Test1ViewController
//
//  Created by user on 14/07/22.
//

import UIKit

let  windowWith : CGFloat = UIScreen.main.bounds.width
let windowHeigt : CGFloat = UIScreen.main.bounds.height

class Test2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        view.backgroundColor = UIColor(red: 0/255, green: 85/255, blue: 85/255, alpha: 1)
        let btn = UIButton(frame: CGRect(x: 60, y: 60, width: 80, height: 40))
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(ooo), for: .touchUpInside)
        view.addSubview(btn)
        
        }
      
    
    
    @objc func ooo(){
      navigationController?.pushViewController(Game15ViewController(), animated: true)
        let vc = Game15ViewController()
//        vc.modalPresentationStyle = .pageSheet
//        present(vc, animated: true)
    }
    }
    

