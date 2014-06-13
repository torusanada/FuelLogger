//
//  AddViewController.m
//  app
//
//  Created by 真田到 on 2014/05/24.
//  Copyright (c) 2014年 Toru Sanada. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController (){
    //インスタンス変数追加
    UIDatePicker *_datePicker;
    BOOL *_visibleFlag;
    UIView *_backView;
}

@end

@implementation AddViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //ここから
    _visibleFlag = NO;
    //Smallビューを作る
    [self CreateSmallView];
    [self CreateDatePicker];
    //ここまで日付表示準備
    
    
    //ここからビューの初期化時にジェスチャをself.viewに登録
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSingleTap:)];
    self.singleTap.delegate = self;
    self.singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:self.singleTap];
    //ここまでキーボード閉じる
  
        //ラベルにdraftから持ってきた辞書データを入れる
        //    NSLog(@"%@",[self.draft objectForKey:@"Date"]);
        self.dateLabel.text = [self.draft objectForKey:@"Date"];
        //    NSLog(@"%@",[self.draft objectForKey:@"Fuel"]);
        self.fuelTextField.text = [self.draft objectForKey:@"Fuel"];
        //    NSLog(@"%@",[self.draft objectForKey:@"Distance"]);
        self.distanceTextField.text =[self.draft objectForKey:@"Distance"];
        //    NSLog(@"%@",[self.draft objectForKey:@"Price"]);
        self.priceTextField.text = [self.draft objectForKey:@"Price"];
    
    
        
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    //MutableArrayにarrayWithArrayをつかってArrayを追加している
    //新しく書き込むデータ
    NSDictionary *newFuelLog =[NSDictionary dictionaryWithObjectsAndKeys:self.dateLabel.text,@"Date",self.fuelTextField.text,@"Fuel",self.distanceTextField.text,@"Distance",self.priceTextField.text,@"Price",nil];
    newFuelLog =[defaults arrayForKey: @"newFuelLog"];
    [defaults synchronize];
    
    
    
    NSLog(@"%@",newFuelLog);
    //tableviewをリロードする
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


//ボタンが上がるメソッド
-(void)UpButton{
    //ボタンが上る
    
    //viewを表示
    _backView.frame = CGRectMake(0, self.view.bounds.size.height-250, self.view.bounds.size.width, 250);
    _backView.alpha = 1.0;
    //文字を
    _visibleFlag = YES;
    
}

//ボタンが下がるメソッド
-(void)DownButton{
    //ボタンが下がる
    
    //---ここから　ボタンも一緒に下がるようにするために書いた
    //viewを表示
    //隠しているサイズ
    _backView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 250);
    _backView.alpha = 0.0;
    
    _visibleFlag = NO;
    //----ここまで
    
}

//datepickerを作る
-(void)CreateDatePicker{
    _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"yyyy/MM/dd HH:mm";
    
    self.dateLabel.text = [df stringFromDate:_datePicker.date];
    _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    
    [_datePicker addTarget:self action:@selector(setDateToLabel) forControlEvents:UIControlEventValueChanged];
    
    [_backView addSubview:_datePicker];
}

//datepickerのアクションを作る
-(void)setDateToLabel{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"yyyy/MM/dd HH:mm";
    
    self.dateLabel.text = [df stringFromDate:_datePicker.date];
    
}


-(void)CreateSmallView{
    
    //水色の部分　　alloc=メモリを確保する
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 250)];
    
//    _backView.backgroundColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
    //alpha透明度　1が透明じゃない　0が透明
    _backView.alpha = 0.0;
    
    [self.view addSubview:_backView];
    
}


- (IBAction)datePick:(id)sender {
    NSLog(@"datePickerTap!");
    
    //
    [UIView beginAnimations:nil context:nil];
    //アニメーションの間隔
    [UIView setAnimationDuration:0.3];
    
    if(_visibleFlag){
        [self DownButton];    }else{
            [self UpButton];

        }}

//シングルタップされたらresignFirstResponderでキーボードを閉じる
-(void)onSingleTap:(UITapGestureRecognizer *)recognizer{
    [self.dateLabel resignFirstResponder];
    [self.fuelTextField resignFirstResponder];
    [self.distanceTextField resignFirstResponder];
    [self.priceTextField resignFirstResponder];
}

//キーボードを表示していない時は、他のジェスチャに影響を与えないように無効化しておく。
-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (gestureRecognizer == self.singleTap) {
        // キーボード表示中のみ有効
        if (self.dateLabel.isFirstResponder ||self.fuelTextField.isFirstResponder ||self.distanceTextField.isFirstResponder||self.priceTextField.isFirstResponder) {
            return YES;
        } else {
            return NO;
        }
    }
    return YES;
}






//Saveアクション
- (IBAction)clickedSaveBtn:(id)sender {
    
    
//どnoようにしょりをかけばいいのか。。。
    if (self.draft ==nil) {
        NSLog(@"新規追加");
        //UserDefaultsでデータの取得(場所の確保)
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        NSLog(@"ClickedBtn");
        
        //(UserDefaultsに配列としてfuelLogを追加)
        //元々保存されたデータ
        NSArray *currentFuelLogs = [defaults arrayForKey: @"newFuelLog"];
        
        //もしcurrentFuelLogsが空の配列だった場合の処理の処理がないので
        //空の配列を初期化する処理を書く
        if (currentFuelLogs == nil){
            currentFuelLogs = [[NSArray alloc] init];
        }
        
        //配列が編集されるのでNSMutabeArray(可変)を使ってポジジョン場所を作成
        //保存用データ
        NSMutableArray *newFuelLogs = [[NSMutableArray alloc] init];
        
        //入力されるデータをNSDictionaryにまとめる
        //新しく保存するデータ
        NSDictionary *newFuelLog =[NSDictionary dictionaryWithObjectsAndKeys:self.dateLabel.text,@"Date",self.fuelTextField.text,@"Fuel",self.distanceTextField.text,@"Distance",self.priceTextField.text,@"Price",nil];
        
        //newFuelLogsにcurrentFuelLogsを追加している
        [newFuelLogs addObjectsFromArray:currentFuelLogs];
        //newFuelLogsにnewFuelLogを追加
        [newFuelLogs addObject:newFuelLog];
        
        //保存の手続き
        //newFuelLogsというオブジェクトにnewFuelLogという名前をつけている
        [defaults setObject:newFuelLogs forKey:@"newFuelLog"];
        NSLog(@"Save!");
        
        //クリア処理
        [defaults synchronize];
        
        
    } else {
    NSLog(@"上書き保存");
        
        
        //UserDefaultsでデータの取得(場所の確保)
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        NSLog(@"ClickedBtn");
        
        //(UserDefaultsに配列としてfuelLogを追加)
        //元々保存されたデータ
        NSArray *currentFuelLogs = [defaults arrayForKey: @"newFuelLog"];
        
        //もしcurrentFuelLogsが空の配列だった場合の処理の処理がないので
        //空の配列を初期化する処理を書く
        if (currentFuelLogs == nil){
            currentFuelLogs = [[NSArray alloc] init];
        }
        
        //配列が編集されるのでNSMutabeArray(可変)を使ってポジジョン場所を作成
        //保存用データ
        NSMutableArray *newFuelLogs = [[NSMutableArray alloc] init];
        
       
        //入力されるデータをNSDictionaryにまとめる
        //新しく保存するデータ
        NSDictionary *newFuelLog =[NSDictionary dictionaryWithObjectsAndKeys:self.dateLabel.text,@"Date",self.fuelTextField.text,@"Fuel",self.distanceTextField.text,@"Distance",self.priceTextField.text,@"Price",nil];
        
        
        //newFuelLogsにcurrentFuelLogsを追加している
        [newFuelLogs addObjectsFromArray:currentFuelLogs];
        
        
        [newFuelLogs replaceObjectAtIndex:self.selectCell.row
                               withObject:newFuelLog];
        
        
        //newFuelLogsにnewFuelLogを追加
        //[newFuelLogs addObject:newFuelLog];
        
        //保存の手続き
        //newFuelLogsというオブジェクトにnewFuelLogという名前をつけている
        [defaults setObject:newFuelLogs forKey:@"newFuelLog"];
        NSLog(@"Save!");
        
        //クリア処理
        [defaults synchronize];
    }
    
    
    
    
    //前画面に戻る処理
    [self.navigationController popViewControllerAnimated:YES];
    
}




- (IBAction)clickedCancelBtn:(id)sender {
    //前画面に戻る処理
    [self.navigationController popViewControllerAnimated:YES];

}
@end
