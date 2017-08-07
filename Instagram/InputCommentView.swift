import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD


class InputCommentView: UIViewController {
    
    let time = NSDate.timeIntervalSinceReferenceDate
    let name = FIRAuth.auth()?.currentUser?.displayName
    var postData:PostData!

    @IBOutlet weak var commentText: UITextView!
    
    @IBAction func PostComment(_ sender: UIButton) {
            // 投稿ボタンをタップしたときに呼ばれるメソッド
        
        // postDataに必要な情報を取得しておく
//        let time = NSDate.timeIntervalSinceReferenceDate
        let name = FIRAuth.auth()?.currentUser?.displayName
        
        // 辞書を作成してFirebaseに保存する
        
//        let commentData = ["comment": commentText.text!, "name": name!]
   
        postData.comments.append(["comment": commentText.text!, "name": name!])
        // 増えたcomentsをFirebaseに保存する
        let postRef = FIRDatabase.database().reference().child(Const.PostPath).child(postData.id!)
        let comments = ["comments":postData.comments]
        postRef.updateChildValues(comments)
        
        
        
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        
        // 全てのモーダルを閉じる
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
