//
//  ViewController.m
//  tableViewMultuSegmentDemo
//
//  Created by Leonel Roberto Perea Trejo on 1/22/14.
//  Copyright (c) 2014 Leonel Roberto Perea Trejo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
NSArray *countriesArray;
NSArray *sportArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _teamsTAble.delegate = self;
    _teamsTAble.dataSource = self;
    countriesArray = [[NSArray alloc]initWithObjects:@"USA", @"Canada", @"Mexico", nil];
    sportArray = [[NSArray alloc]initWithObjects:@"Baseball", @"Football", nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return [countriesArray count];
    }else{
        return [sportArray count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"MyCell";
    UITableViewCell *thisCell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(thisCell==nil){
        thisCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    if(indexPath.section == 0){
        thisCell.textLabel.text = [countriesArray objectAtIndex:indexPath.row];
    }else{
        thisCell.textLabel.text = [sportArray objectAtIndex:indexPath.row];
    }
    return thisCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        _lblOutput.text = [countriesArray objectAtIndex:indexPath.row];
    }else{
        _lblOutput.text = [sportArray objectAtIndex:indexPath.row];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
