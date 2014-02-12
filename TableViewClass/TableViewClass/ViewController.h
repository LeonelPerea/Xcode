//
//  ViewController.h
//  TableViewClass
//
//  Created by Leonel Roberto Perea Trejo on 1/22/14.
//  Copyright (c) 2014 Leonel Roberto Perea Trejo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *teamsTable;

@end
