//
//  Game15ViewController.swift
//  Test1ViewController
//
//  Created by user on 14/07/22.
//

import UIKit


let windowwidth = UIScreen.main.bounds.width
let windowheight = UIScreen.main.bounds.height

class Game15ViewController: UIViewController {
    var baseView : UIView!
    var buttonlist = [UIButton]()
    var arragment = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        
        
        
        
        baseView = UIView(frame: CGRect(x: 10, y: 90, width: windowwidth - 20, height: windowwidth - 20))
        baseView.backgroundColor = .blue
        view.addSubview(baseView)
        
        
        
        
        
        let resetbtn = UIButton(frame: CGRect(x: baseView.frame.width / 3 + 30, y: baseView.frame.maxY + 20, width: 100, height: 50))
        resetbtn.setTitle("restart", for: .normal)
        resetbtn.setTitleColor(.black, for: .normal)
        resetbtn.backgroundColor = .orange
        resetbtn.layer.cornerRadius = 8
        resetbtn.addTarget(self, action: #selector(restart(_ :)), for: .touchUpInside)
        view.addSubview(resetbtn)
        
       // MARK: Button UI
        let space: CGFloat = 10
        let btnsize:CGFloat = (baseView.frame.width - 5 * space) / 4
   
        var count = 0
        for i in 1 ... 4{
            for j in 1 ... 4{
                drawbtn(size: CGRect(x: CGFloat(j)*space + CGFloat(j-1)*btnsize, y: CGFloat(i)*space + CGFloat(i-1)*btnsize, width: btnsize, height: btnsize), tag: count)
                count += 1

            }
            
        }
        
        
        for i in 0 ... 190 {
            shuffle()
        }
        
    }
    
    @objc func restart(_ sender: UIButton){
        for i in 0 ... 190 {
            shuffle()
        }
    }
    
    
    
    func drawbtn(size: CGRect,tag:Int){
        let btn = UIButton(frame: size)
        btn.tag = tag
        btn.setTitle(String(tag+1), for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 8
        btn.addTarget(self, action: #selector(walking(_:)), for: .touchUpInside)
        buttonlist.append(btn)
        baseView.addSubview(btn)
        if tag == 15 {
            btn.isHidden = true
        }
//        buttonlist[14].isHidden = true
    }
    func shuffle(){
        var a : Int!
        var liststep = [Int]()

        for i in 0 ... 15{
            if buttonlist[i].isHidden{
                a = i
                break
            }
            
        }
        
        if a > 0 && a % 4 != 0{
                    liststep.append(a-1)
                }
                if a < 15 && a % 4 != 3{
                    liststep.append(a+1)
                }
                if a > 3{
                    liststep.append(a-4)
                }

                if a < 12{
                    liststep.append(a+4)
                }
        
        
        if let value = liststep.randomElement(){
            change(a: a , value: value)
        }
        
    }
    
    
    func change(a:Int,value: Int){
        let temp = arragment[a]
        arragment[a] = arragment[value]
        arragment[value] = temp
        buttonlist[a].setTitle("\(arragment[a])", for: .normal)
        buttonlist[a].isHidden = false
        buttonlist[value].isHidden = true
        
    }
    
    @objc func walking(_ sender: UIButton){
            if sender.tag > 0 && sender.tag % 4 != 0 && buttonlist[sender.tag-1].isHidden{
                change(a: sender.tag - 1, value: sender.tag)
            }else  if sender.tag < 15 && sender.tag % 4 != 3 && buttonlist[sender.tag+1].isHidden{
                change(a: sender.tag + 1, value: sender.tag)
            }else  if sender.tag > 3 && buttonlist[sender.tag-4].isHidden{
                change(a: sender.tag - 4, value: sender.tag)
            }else  if sender.tag < 12 && buttonlist[sender.tag+4].isHidden{
                change(a: sender.tag + 4, value: sender.tag)
            }
        }
    

}
