//
//  ViewController.h
//  app
//
//  Created by 真田到 on 2014/05/24.
//  Copyright (c) 2014年 Toru Sanada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"
#import "AddViewController.h"

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

//Storyboardに貼ったTableViewをリンクした
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//strogは省略しても同じ意味 NSMutableArrayのproperty作成
@property(nonatomic) NSMutableArray *dataList;
- (IBAction)clickedEditBtn:(id)sender;
- (IBAction)clickedAddBtn:(id)sender;

//新規画面に追加するかどうかのflag
@property(nonatomic,assign)BOOL isNewEditingFuelLog;

@end
