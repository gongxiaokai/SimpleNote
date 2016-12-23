//
//  DetailViewController.swift
//  SimpleNote
//
//  Created by gongwenkai on 2016/12/23.
//  Copyright © 2016年 gongwenkai. All rights reserved.
//

import UIKit
import CoreData
class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var detailTextView: UITextView!
    
    //配置界面 显示日志内容
    func configureView() {
        if let detail = self.detailItem {
            if let textView = self.detailTextView {
                textView.text = detail.noteDetail!.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //增加保存按钮
        let saveBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveObject))
        self.navigationItem.rightBarButtonItem = saveBtn
        self.title = "写点什么吧..."
        
        self.configureView()
    }

    //保存数据
    func saveObject() {
        print("saved")
        
        let newEvent = self.detailItem
        let context = self.detailItem?.managedObjectContext
        newEvent?.noteDetail = self.detailTextView.text
        newEvent?.timestamp = NSDate()
        self.saveData(context: context!)
        //返回
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //删除
    @IBAction func deleteNote(_ sender: Any) {
        print("deleted")
        let context = self.detailItem?.managedObjectContext
        context?.delete(self.detailItem!)
        self.saveData(context: context!)
        _ = self.navigationController?.popViewController(animated: true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //当前entity
    var detailItem: Event? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    //保存数据
    func saveData(context:NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

