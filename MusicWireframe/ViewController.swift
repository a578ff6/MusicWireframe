//
//  ViewController.swift
//  MusicWireframe
//
//  Created by 曹家瑋 on 2023/10/26.
//

/*
import UIKit

class ViewController: UIViewController {

    // 音樂封面
    @IBOutlet weak var albumImageView: UIImageView!
    // 手指陰影
    @IBOutlet weak var reverseBackground: UIView!
    @IBOutlet weak var playPauseBackground: UIView!
    @IBOutlet weak var forwardBackground: UIView!
    // 按鈕
    @IBOutlet weak var reverseButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    // 追蹤是否正在播放
    var isPlaying: Bool = true {
        didSet {
            // 當播放狀態改變時，更新按鈕的選擇狀態
            playPauseButton.isSelected = isPlaying
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 對每個視圖設置圓角和裁剪屬性
        [reverseBackground, playPauseBackground, forwardBackground].forEach { view in
            view.layer.cornerRadius = view.frame.height / 2
            view.clipsToBounds = true
            // 初始時將視圖設為完全透明，隱藏狀態
            view.alpha = 0.0
        }

    }

    @IBAction func playPauseButtonTapped(_ sender: UIButton) {
        // 切換播放狀態
        isPlaying.toggle()
        
        if isPlaying {
            // 如果正在播放，則使用帶有彈簧效果的動畫
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: [], animations: {
                // 恢復到原始狀態
                self.albumImageView.transform = CGAffineTransform.identity
            }, completion: nil)
        } else {
            // 如果暫停播放，則縮小圖像視圖
            UIView.animate(withDuration: 1) {
                // 將圖像視圖縮小到原始大小的80％
                self.albumImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        }
    }
    
    // 按下按鈕
    @IBAction func touchedDown(_ sender: UIButton) {
        // 宣告 UIView 變數來存放要動畫的按鈕背景。
        let buttonBackground: UIView
        
        // 判斷是哪個按鈕被按下，並指派相對應的手指陰影背景給 'buttonBackground'。
        switch sender {
        case reverseButton:
            buttonBackground = reverseBackground
        case playPauseButton:
            buttonBackground = playPauseBackground
        case forwardButton:
            buttonBackground = forwardBackground
        default:
            return
        }
        
        // 執行動畫
        UIView.animate(withDuration: 0.25) {
            // 設定按鈕背景的透明度為0.3，讓其稍微顯示
            buttonBackground.alpha = 0.3
            // 設定按鈕大小縮放到原來的0.8倍
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
    // 放開按鈕
    @IBAction func touchedUpInside(_ sender: UIButton) {
        let buttonBackground: UIView
        
        // 判斷是哪個按鈕被按下，並指派相對應的手指陰影背景給 'buttonBackground'。
        switch sender {
        case reverseButton:
            buttonBackground = reverseBackground
        case playPauseButton:
            buttonBackground = playPauseBackground
        case forwardButton:
            buttonBackground = forwardBackground
        default:
            return
        }
        
        // 當放開按鈕時，背景會完全消失且稍微放大，按鈕則恢復原狀。動畫完成後，背景視圖也要恢復原狀。
        UIView.animate(withDuration: 0.25, animations: {
            buttonBackground.alpha = 0.0
            buttonBackground.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)     // 背景視圖（手指陰影）放大到1.2倍
            sender.transform = CGAffineTransform.identity       // （由於前面按鈕按下有動畫效果）因此撤銷，讓按鈕視圖恢復到原始大小和位置
        }) { (_) in // 動畫完成後
            buttonBackground.transform = CGAffineTransform.identity     // 背景視圖也要恢復到原始的大小和位置
        }
    }
    
    
}
*/

// MARK: - UIViewPropertyAnimator

import UIKit

class ViewController: UIViewController {

    // 音樂封面
    @IBOutlet weak var albumImageView: UIImageView!
    // 手指陰影
    @IBOutlet weak var reverseBackground: UIView!
    @IBOutlet weak var playPauseBackground: UIView!
    @IBOutlet weak var forwardBackground: UIView!
    // 按鈕
    @IBOutlet weak var reverseButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    // 追蹤是否正在播放
    var isPlaying: Bool = true {
        didSet {
            // 當播放狀態改變時，更新按鈕的選擇狀態
            playPauseButton.isSelected = isPlaying
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 對每個視圖設置圓角和裁剪屬性
        [reverseBackground, playPauseBackground, forwardBackground].forEach { view in
            view.layer.cornerRadius = view.frame.height / 2
            view.clipsToBounds = true
            // 初始時將視圖設為完全透明，隱藏狀態
            view.alpha = 0.0
        }

    }

    @IBAction func playPauseButtonTapped(_ sender: UIButton) {
        // 切換播放狀態
        isPlaying.toggle()
        
        if isPlaying {
            // 如果正在播放，則使用帶有彈簧效果的動畫
            let animator = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.4) {
                // 恢復圖像到原來的尺寸和位置（如果之前有變化的話）
                self.albumImageView.transform = CGAffineTransform.identity
            }
            // 延遲為0，立即開始動畫
            animator.startAnimation(afterDelay: 0)
        } else {
            // 如果暫停播放，則縮小圖像視圖
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1, delay: 0, options: [], animations: {
                // 將圖像視圖縮小到原始大小的80％
                self.albumImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }, completion: nil)
        }
    }
    
    // 按下按鈕
    @IBAction func touchedDown(_ sender: UIButton) {
        // 宣告 UIView 變數來存放要動畫的按鈕背景。
        let buttonBackground: UIView
        
        // 判斷是哪個按鈕被按下，並指派相對應的手指陰影背景給 'buttonBackground'。
        switch sender {
        case reverseButton:
            buttonBackground = reverseBackground
        case playPauseButton:
            buttonBackground = playPauseBackground
        case forwardButton:
            buttonBackground = forwardBackground
        default:
            return
        }
        
        // 執行動畫
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.25, delay: 0, options: [], animations: {
            // 設定按鈕背景的透明度為0.3，讓其稍微顯示
            buttonBackground.alpha = 0.3
            // 設定按鈕大小縮放到原來的0.8倍
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: nil)
 
    }
    
    // 放開按鈕
    @IBAction func touchedUpInside(_ sender: UIButton) {
        let buttonBackground: UIView
        
        // 判斷是哪個按鈕被按下，並指派相對應的手指陰影背景給 'buttonBackground'。
        switch sender {
        case reverseButton:
            buttonBackground = reverseBackground
        case playPauseButton:
            buttonBackground = playPauseBackground
        case forwardButton:
            buttonBackground = forwardBackground
        default:
            return
        }
        
        // 當放開按鈕時，背景會完全消失且稍微放大，按鈕則恢復原狀。動畫完成後，背景視圖也要恢復原狀。
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.25, delay: 0, options: [], animations: {
            buttonBackground.alpha = 0.0
            buttonBackground.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)  // 背景視圖（手指陰影）放大到1.2倍
            sender.transform = CGAffineTransform.identity
        }) { (_) in
            buttonBackground.transform = CGAffineTransform.identity // 背景視圖也要恢復到原始的大小和位置
        }
        
    }
    
    
}
