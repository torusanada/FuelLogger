//
//  AddViewController.h
//  app
//
//  Created by 真田到 on 2014/05/24.
//  Copyright (c) 2014年 Toru Sanada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UITableViewController<UITextFieldDelegate, UIGestureRecognizerDelegate>

//キーボードを閉じるためのシングルタップジェスチャを用意
@property(nonatomic,strong) UITapGestureRecognizer *singleTap;


- (IBAction)datePick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextField *fuelTextField;
@property (weak, nonatomic) IBOutlet UITextField *distanceTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;

//VIEWCONTROLLERから持ってきたDRAFTをpropertyに入れる
@property(strong,nonatomic) NSDictionary *draft;
@property(strong,nonatomic) NSIndexPath *selectCell;
- (IBAction)clickedSaveBtn:(id)sender;
- (IBAction)clickedCancelBtn:(id)sender;



@end
