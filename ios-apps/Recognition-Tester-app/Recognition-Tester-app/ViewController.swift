//
//  ViewController.swift
//  Recognition-Tester-app
//
//  Created by koki on 2016/07/05.
//  Copyright © 2016年 LumberMill, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var btnCamera: UIBarButtonItem!
    var api: RecognitionAPI?
    var queryImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pushCameraButton(sender: AnyObject) {
        cameraStart(self)
    }
    
    @IBAction func back(segue:UIStoryboardSegue){//戻るボタン用
        print("back")
        lblInfo.text = "カメラを起動して商品を撮影して下さい"
    }
    
    func cameraStart(sender: AnyObject) {
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.Camera
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            btnCamera.enabled = false
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            
            lblInfo.text = "撮影中.."
            self.presentViewController(cameraPicker, animated: true, completion: nil)
        }
        else{
            lblInfo.text = "カメラが使用できません"
            btnCamera.enabled = true
        }
    }
    
    //　撮影が完了時した時に呼ばれる
    func imagePickerController(imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        queryImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        if (queryImage != nil) {
            // APIに問い合わせる
            api = RecognitionAPI()
            api!.send(queryImage!, callback: {_, _, _ in
                dispatch_async(dispatch_get_main_queue()) {
                    // 問い合わせ終了後
                    self.btnCamera.enabled = true
                    print(self.api!.result)
                    if (!self.api!.error) {
                        self.lblInfo.text = "APIからデータを取得しました。結果を表示します"
                        // 結果一覧画面へ
                        self.performSegueWithIdentifier("showResult", sender: self)
                    } else {
                        self.lblInfo.text = "APIへの問い合わせでエラーが発生しました"
                    }
                }
            })
        }
        
        //閉じる処理
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        lblInfo.text = "APIに問い合わせ中.."
    }
    
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        lblInfo.text = "撮影がキャンセルされました"
        btnCamera.enabled = true // 問い合わせ終了後
    }
    
    // Segueで画面遷移するときに呼ばれる
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let next_vc = segue.destinationViewController as! ResultTableViewController
        next_vc.api_result_dict = api!.result_dict
        next_vc.query_image = queryImage!
    }
    
}

