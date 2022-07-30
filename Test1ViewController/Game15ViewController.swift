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
    var winList = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
    var emptyList = [Int]()
    private var label : UILabel!
    private var timer : Timer?
    private var timelimit : Int = 10
    private var currenttime: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        self.initGesture()
        self.startTimer()
        
        label = UILabel(frame: CGRect(x: 145, y: 100, width: 90, height: 50))
        label.backgroundColor = .cyan
        label.text = "00 : 00"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        view.addSubview(label)
        
        baseView = UIView(frame: CGRect(x: 10, y: 190, width: windowwidth - 20, height: windowwidth - 20))
        baseView.backgroundColor = .blue
        view.addSubview(baseView)
        
        
        
        
        
        //        let resetbtn = UIButton(frame: CGRect(x: baseView.frame.width / 3 + 30, y: baseView.frame.maxY + 220, width: 75, height: 50))
        //        resetbtn.setTitle("restart", for: .normal)
        //        resetbtn.setTitleColor(.black, for: .normal)
        //        resetbtn.backgroundColor = .orange
        //        resetbtn.layer.cornerRadius = 8
        //        resetbtn.addTarget(self, action: #selector(restart(_ :)), for: .touchUpInside)
        //        view.addSubview(resetbtn)
        //
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
        
        
        for _ in 0 ... 190 {
            shuffle()
        }
        
        
        let top = UIButton(frame: CGRect(x: 170, y: baseView.frame.maxY+20, width: 60, height: 40))
        top.tag = 3
        top.setTitle("up" , for: .normal)
        top.setTitleColor(.black, for: .normal)
        top.backgroundColor = .white
        top.layer.cornerRadius = 8
        top.addTarget(self, action: #selector(knopka(_ :)), for: .touchUpInside)
        view.addSubview(top)
        
        let bottom = UIButton(frame: CGRect(x: 170, y: baseView.frame.maxY+110, width: 60, height: 40))
        bottom.tag = 4
        bottom.setTitle("bottom" , for: .normal)
        bottom.setTitleColor(.black, for: .normal)
        bottom.backgroundColor = .white
        bottom.layer.cornerRadius = 8
        bottom.addTarget(self, action: #selector(knopka(_ :)), for: .touchUpInside)
        view.addSubview(bottom)
        
        
        let left = UIButton(frame: CGRect(x: 80, y: baseView.frame.maxY+65, width: 60, height: 40))
        left.tag = 1
        left.setTitle("left" , for: .normal)
        left.setTitleColor(.black, for: .normal)
        left.backgroundColor = .white
        left.layer.cornerRadius = 8
        left.addTarget(self, action: #selector(knopka(_ :)), for: .touchUpInside)
        view.addSubview(left)
        
        
        let right = UIButton(frame: CGRect(x: 250, y: baseView.frame.maxY + 65, width: 60, height: 40))
        right.tag = 2
        right.setTitle("right" , for: .normal)
        right.setTitleColor(.black, for: .normal)
        right.backgroundColor = .white
        right.layer.cornerRadius = 8
        right.addTarget(self, action: #selector(knopka(_ :)), for: .touchUpInside)
        view.addSubview(right)
        
        
        
    }
    @objc func onTimer(){
        currenttime += 1
        if currenttime >= timelimit{
            self.alerFunction()
        }else{
            let minut = currenttime / 60
            let second = currenttime % 60
            label.text = "0\(minut) : \((second < 10 ? "0\(second)" : ""))"
        }
        
    }
    private func startTimer(){
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimer), userInfo: nil, repeats: true)
    }
    private func stopTimer(){
        self.timer?.invalidate()
        self.timer = nil
    }
    
    @objc func onSwipe(_ gesture: UISwipeGestureRecognizer){
        var a : Int!
        for i in 0 ... 15{
            if buttonlist[i].isHidden{
                a = i
                break
            }
        }
        if gesture.direction == .up{
            print("swipeUp gesture is active")
            if a+4 < buttonlist.count{
                change(a: a, value: a+4)
            }
        }else if gesture.direction == .down{
            print("swipeDown is active")
            if a >= 4 {
                change(a: a, value: a-4)
            }
        }else if gesture.direction == .left{
            print("swipeLeft is active")
            if (a+1) % 4 != 0 && a+1 < buttonlist.count {
                change(a: a, value: a+1)
            }
        }else if gesture.direction == .right{
            print("swipright is active")
            if (a-1) % 4 != 3 && a-1 >= 0 {
                change(a: a, value: a-1)
            }
        }
    }
    func initGesture(){
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe(_:)))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe(_:)))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe(_:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        let swiperight = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe(_:)))
        swiperight.direction = .right
        view.addGestureRecognizer(swiperight)
    }
    
    private func alerFunction(){
        let alert = UIAlertController(title: "Message", message: "Vaqt tugadi bro!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default){ action in
            self.stopTimer()
            self.currenttime = 0
            for _ in 0 ... 200 {
                self.shuffle()
            }
            self.startTimer()
        }
        alert.addAction(okAction)
        
        alert.modalPresentationStyle = .fullScreen
        present(alert, animated: true)
    }
    @objc func knopka(_ sender : UIButton){
        var a : Int!
        
        for i in 0 ... 15{
            if buttonlist[i].isHidden{
                a = i
                break
            }
            
        }
        
        if sender.tag == 1{
            
            replacing2(a: a, value: a+1,tag: sender.tag)
        }else if sender.tag == 2{
            
            replacing2(a: a, value: a-1,tag: sender.tag)
            
            
        }else if sender.tag == 3{
            //            if !buttons[a-].isHidden{
            replacing2(a: a, value: a+4,tag: sender.tag)
            
        }else{
            replacing2(a: a, value: a-4,tag: sender.tag)
        }
        
        check()
    }
    
    func check(){
        for i in 0 ... 15{
            if let value = buttonlist[i].titleLabel?.text{
                if !emptyList.contains(Int(value) ?? 0){
                    emptyList.append(Int(value) ?? 0)
                }
            }
        }
        if emptyList == winList{
            winCheck()
        }
        emptyList.removeAll()
    }
    
    @objc func restart(_ sender: UIButton){
        for _ in 0 ... 190 {
            shuffle()
        }
    }
    
    @objc func winCheck(){
        
        
        let alert = UIAlertController(title: "Xushhabar!", message: "YOU WIN BRO !", preferredStyle: .alert)
        present(alert, animated: true)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        let restartAction = UIAlertAction(title: "Restart", style: .default)
        alert.addAction(okAction)
        alert.addAction(restartAction)
        self.present(alert, animated: true)
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
    
    
    func replacing2(a: Int, value: Int,tag: Int){
        
        if a+4 < buttonlist.count && tag == 3{
            let temp = arragment[a]
            arragment[a] = arragment[value]
            arragment[value] = temp
            buttonlist[a].setTitle("\(arragment[a])", for: .normal)
            buttonlist[a].isHidden = false
            buttonlist[value].isHidden = true
        }else if (a+1) % 4 != 0 && a+1 < buttonlist.count && tag == 1{
            let temp = arragment[a]
            arragment[a] = arragment[value]
            arragment[value] = temp
            buttonlist[a].setTitle("\(arragment[a])", for: .normal)
            buttonlist[a].isHidden = false
            buttonlist[value].isHidden = true
            
        }else if (a-1) % 4 != 3 && a-1 >= 0  && tag == 2{
            let temp = arragment[a]
            arragment[a] = arragment[value]
            arragment[value] = temp
            buttonlist[a].setTitle("\(arragment[a])", for: .normal)
            buttonlist[a].isHidden = false
            buttonlist[value].isHidden = true
            
        }else if a >= 4 && tag == 4{
            let temp = arragment[a]
            arragment[a] = arragment[value]
            arragment[value] = temp
            buttonlist[a].setTitle("\(arragment[a])", for: .normal)
            buttonlist[a].isHidden = false
            buttonlist[value].isHidden = true
        }
        
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
        check()
        stopTimer()
        currenttime = 0
        self.label.text = "00 : 00"
        startTimer()
    }
    
    
}
