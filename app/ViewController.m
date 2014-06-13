//
//  ViewController.m
//  app
//
//  Created by 真田到 on 2014/05/24.
//  Copyright (c) 2014年 Toru Sanada. All rights reserved.
//

#import "ViewController.h"
#import "AddViewController.h"
#import "CustomCell.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.tableView.dataSource =self;
    self.tableView.delegate = self;
    
    //カスタムセルを使用
    //CustomXibからCustomCellという名前のついたオブジェクトを呼び出す
    //次にidentityにCustomCellの名前を入れる
    UINib *nib =[UINib nibWithNibName:@"CustomCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    
    //dataArrayに保存
//   NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
//    self.dataList =[defaults objectForKey:@"dataArray"];
    
     NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
     NSArray *currentFuelLogs = [defaults arrayForKey: @"newfuelLog"];
    [defaults synchronize];
    
    //ナビゲーションバーを青色に変える
    self.navigationController.navigationBar.barTintColor =
    [UIColor colorWithRed:0.000 green:0.549 blue:0.890 alpha:1.000];
    
    // ナビゲーションボタンを赤色に変える
    self.navigationController.navigationBar.tintColor =
    [UIColor whiteColor];
    
    // ナビゲーションバーのタイトルの色を変更
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    //MutableArrayにarrayWithArrayをつかってArrayを追加している
    self.dataList = [NSMutableArray arrayWithArray:[defaults arrayForKey: @"newFuelLog"]];
    NSLog(@"dataList");
    
    

    NSLog(@"%@",self.dataList);
    //tableviewをリロードする
    [self.tableView reloadData];
    
}


//セクションの数を指定
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//行の数を指定
//数が登録数により変わるのでdataListにしている
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%d",self.dataList.count);
    return self.dataList.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellIdentifier = @"Cell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"
                                                       forIndexPath:indexPath];
    //セルに矢印を追加している。
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //＝は２個必要
    if (cell == nil){
        
        //表示のスタイルを決定
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        
    }
    
    //辞書データの今見ている行を呼び出す
    NSDictionary *FuelLog = [self.dataList objectAtIndex:indexPath.row];
    //セルに辞書データのPriceをpriceLabelに入れる
    
    
    cell.dateLabel.text = [FuelLog objectForKey:@"Date" ];
    cell.fuelLabel.text = [NSString stringWithFormat:@"%@ ℓ",[FuelLog objectForKey:@"Fuel"]];
    cell.distanceLabel.text = [NSString stringWithFormat:@"%@ Km",[FuelLog objectForKey:@"Distance"]];
    cell.priceLabel.text = [NSString stringWithFormat:@"%@ 円",[FuelLog objectForKey:@"Price"]];
    
    
//    NSString *fuelMix = [NSString stringWithFormat:@"%@リットル",[FuelLog objectForKey:@"Fuel"]];
//    
//    cell.fuelLabel.text = fuelMix;
    
    
    
/*
    NSLog(@"@%",newFuelLo.allkeys);
    
    NSLog(@"@%",[newFuelLog objectForKey:@"Date"]);
    
    cell.dateLabel.text = [NSString stringWithFormat:@"%@",self.dataList [indexPath.row]];
     cell.fuelLabel.text = [NSString stringWithFormat:@"%@",self.dataList[indexPath.row]];
     cell.distanceLabel.text = [NSString stringWithFormat:@"%@",self.dataList[indexPath.row]];
     cell.priceLabel.text = [NSString stringWithFormat:@"%@",self.dataList[indexPath.row]];
    
    [NSArray objectAtIndex:2];
    //
    NSDictionary *FuelLog = [self.dataList objectAtIndex:indexPath.row];
    NSLog(@"@%",FuelLog.allkeys);
    NSLog(@"@%",FuelLog objectForKey:@"Price"]);

    
//    NSLog(@"%d",self.dataList.count);
*/
    return cell;
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    
////    AddViewController *dvc = [segue destinationViewController];
////    dvc.selectnum = self.tableView.indexPathForSelectedRow.row;
////    
//    
//    NSLog(@"%d",self.tableView.indexPathForSelectedRow.row);
//}


////    配列のデータをカウントして、その数だけセルを作る。
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    return counter.count;
//    
//}
//
////    Cellに配列内の値を表示させる
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell;
//    cell = [[UITableViewCell alloc] init];
//    
//}
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([[segue identifier] isEqualToString:@"ShowAddItemView"]) {
//        
//        // 遷移先のAddItemViewControllerのインスタンスを取得
//        AddViewController *addViewController = (addViewController *)[[[segue destinationViewController]viewControllers]objectAtIndex:0];
//        
//        // delegateプロパティに self(MasterViewController自身)をセット
//        addViewController.delegate = self;
//    }else{
//        //編集画面に移動する
//
//        
//    }
//}

// Cell が選択された時 実行する
//ストーリーボードのselectionでタップの設定変えられる。通常シングルタップ
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      NSLog(@"ClickedCell");
    
    self.isNewEditingFuelLog =NO;

    [self performSegueWithIdentifier:@"push" sender:self];
}



// 実行された後、遷移するための準備(データを呼び出して編集画面に写す)
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"push"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *FuelLog;

        //もしデータの数がゼロだったら
        if (self.dataList.count ==nil) {
            
        }else{
            FuelLog = [self.dataList objectAtIndex:indexPath.row];
            

        }
        //遷移先のViewControllerがAddViewControllerだ
        //なのでAddViewControllerに代入できる
        AddViewController *addView = segue.destinationViewController;
        
        //addViewのドラフトはfuelLogと設定
        addView.draft = FuelLog;
        addView.selectCell = indexPath;
        
               //もしisNew..Logが選択されたらdraftは不要の処理
        if (self.isNewEditingFuelLog) {
            
              addView.draft =nil;
        }else{
          
           
        }
        
        //destViewController.recipeName = [ objectAtIndex:indexPath.row];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//削除ボタン
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // 削除ボタンが押された行のデータを配列から削除します。
        [self.dataList removeObjectAtIndex:indexPath.row];         [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        //データの再保存
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.dataList forKey:@"newFuelLog"];
        NSLog(@"Save!");
        

        //クリア処理
        [defaults synchronize];
        
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // ここは空のままでOKです。
    }
}

//削除ボタンのアクション
- (IBAction)clickedEditBtn:(id)sender {
    if (self.tableView.editing)
    {
        [self.tableView setEditing:NO animated:YES];
       
    }
    else
    {

        [self.tableView setEditing:YES animated:YES];
    }
}

//追加ボタンを押した時はisNewを選ぶ
- (IBAction)clickedAddBtn:(id)sender {
    
    self.isNewEditingFuelLog =YES;
}
@end
