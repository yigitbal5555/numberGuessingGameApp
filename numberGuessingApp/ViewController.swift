//
//  ViewController.swift
//  numberGuessingApp
//  written by Yiğit BAL
//  Created by Apple on 10.07.2024.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var txtTahminEdilecekSayi: UITextField!
    @IBOutlet weak var txtTahminSayisi: UITextField!
    @IBOutlet weak var ImgKaydet: UIImageView!
    @IBOutlet weak var btnKaydet: UIButton!
    @IBOutlet weak var ImgTahminDurum: UIImageView!
    @IBOutlet weak var btnDene: UIButton!
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var ImgYıldız1: UIImageView!
    @IBOutlet weak var ImgYıldız2: UIImageView!
    @IBOutlet weak var ImgYıldız3: UIImageView!
    @IBOutlet weak var ImgYıldız4: UIImageView!
    @IBOutlet weak var ImgYıldız5: UIImageView!
    
    
    
    var yıldızlar : [UIImageView] = [UIImageView]()
    
    let maxDenemeSayisi : Int = 5
    var denemeSayisi : Int = 0
    var hedefSayi : Int = -1
    var oyunBasarili : Bool = false
  
    
    
    
    
    override func viewDidLoad() {
           super.viewDidLoad()
        
           yıldızlar = [ImgYıldız1,ImgYıldız2,ImgYıldız3,ImgYıldız4,ImgYıldız5]
        
           ImgKaydet.isHidden = true
        
           ImgTahminDurum.isHidden = true
        
           btnDene.isEnabled = false
        
           txtTahminEdilecekSayi.isSecureTextEntry = true
        
           lblResult.text = ""
           
           
       }
       @IBAction func btnKaydetClicked(_ sender: UIButton) {
           ImgKaydet.isHidden = false
           if let t = Int(txtTahminEdilecekSayi.text!) {
               hedefSayi = t
               btnDene.isEnabled = true
               txtTahminEdilecekSayi.isEnabled = false
               btnKaydet.isEnabled = false
               ImgKaydet.image = UIImage(named: "onay")
           }else{
               ImgKaydet.image = UIImage(named: "hata")
           }
       }
       
       @IBAction func btnDeneClicked(_ sender: UIButton) {
         
           if oyunBasarili == true || denemeSayisi > maxDenemeSayisi {
               return
           }
           if let girilenSayi = Int(txtTahminSayisi.text!) {
               
               denemeSayisi += 1
               yıldızlar[denemeSayisi-1].image = UIImage(named: "beyazYildiz")
               ImgTahminDurum.isHidden = false
               if girilenSayi > hedefSayi {
                   ImgTahminDurum.image = UIImage(named: "asagi")
                   txtTahminSayisi.backgroundColor = UIColor.red
               }else if girilenSayi < hedefSayi {
                   ImgTahminDurum.image = UIImage(named: "yukari")
                   txtTahminSayisi.backgroundColor = UIColor.red
               }else {
                  
                      ImgTahminDurum.image = UIImage(named: "tamam")
                      btnKaydet.isEnabled = false
                      btnDene.isEnabled = false
                      lblResult.text = "DOĞRU TAHMİN! Tebrikler :))"
                      txtTahminSayisi.backgroundColor = UIColor.green
                      txtTahminEdilecekSayi.isSecureTextEntry = false
                   oyunBasarili = true
                   showPlayAgainAlert()
                   
                   return
                      
                  }
             
           }else{
           
               ImgTahminDurum.isHidden = false
               ImgTahminDurum.image = UIImage(named: "hata")
           }
           
           if denemeSayisi == maxDenemeSayisi {
               btnDene.isEnabled = false
               ImgTahminDurum.image = UIImage(named: "hata")
               lblResult.text = "OYUN BAŞARISIZ! \nArkadaşın \(hedefSayi) Sayısını Girdi."
               txtTahminEdilecekSayi.isSecureTextEntry = false
               showGamePlayAgainAlert()
               return
           }
       }
       func showPlayAgainAlert() {
              let alertController = UIAlertController(title: "TAHMİN DOĞRU!", message: "TEBRİKLER! Yeniden başlamak istiyor musunuz?", preferredStyle: .alert)
              
              let yesAction = UIAlertAction(title: "Evet", style: .default) { (_) in
                  self.resetGame()
              }
              alertController.addAction(yesAction)
              
              let noAction = UIAlertAction(title: "Hayır", style: .cancel, handler: nil)
              alertController.addAction(noAction)
              
              present(alertController, animated: true, completion: nil)
          }
       func showGamePlayAgainAlert() {
              let alertController = UIAlertController(title: "TAHMİN YANLIŞ", message: "Girilen Sayı \(hedefSayi). Yeniden başlamak istiyor musunuz?", preferredStyle: .alert)
              
              let yesAction = UIAlertAction(title: "Evet", style: .default) { (_) in
                  self.resetGame()
              }
              alertController.addAction(yesAction)
              
              let noAction = UIAlertAction(title: "Hayır", style: .cancel, handler: nil)
              alertController.addAction(noAction)
              
              present(alertController, animated: true, completion: nil)
          }
    
       func resetGame() {
             denemeSayisi = 0
             hedefSayi = -1
             oyunBasarili = false
             lblResult.text = ""
             txtTahminEdilecekSayi.text = ""
             txtTahminSayisi.text = ""
             for imageView in yıldızlar {
                 imageView.image = UIImage(named: "sariYildiz")
             }
             ImgKaydet.isHidden = true
             ImgTahminDurum.isHidden = true
             btnKaydet.isEnabled = true
             btnDene.isEnabled = false
             txtTahminEdilecekSayi.isEnabled = true
             txtTahminEdilecekSayi.isSecureTextEntry = true
             txtTahminSayisi.backgroundColor = UIColor.white
         }
   }
