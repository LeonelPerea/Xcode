//
//  ViewController.m
//  TableViewClass
//
//  Created by Leonel Roberto Perea Trejo on 1/22/14.
//  Copyright (c) 2014 Leonel Roberto Perea Trejo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
NSArray *teamsArray;

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _teamsTable.dataSource = self;
    _teamsTable.delegate = self;
    teamsArray = [[NSArray alloc]initWithObjects:@"Lupe 93.3", @"Pop 95.9",nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [teamsArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     static NSString *simplreTableIdentifier = @"TeamCell";
    UITableViewCell *thisCell = [tableView dequeueReusableCellWithIdentifier:simplreTableIdentifier];
    if(thisCell==nil){
        thisCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simplreTableIdentifier];
    }
    thisCell.textLabel.text = [teamsArray objectAtIndex:indexPath.row];
    return thisCell;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
