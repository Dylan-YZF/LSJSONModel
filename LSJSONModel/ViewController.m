//
//  ViewController.m
//  LSJSONModel
//
//  Created by Dylan on 16/4/18.
//  Copyright © 2016年 dylan. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()
{
    NSArray* listData;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    listData = @[@"字典 --> 模型",@"数组 --> 模型"];
}


- (void)modelWithDictionary
{
    NSDictionary* dict = [self getDict];
    
    Person * model = [[Person alloc] initWithDictionary:dict];
    
    NSLog(@"name --%@",model.name);
    NSLog(@"sex --%@",model.sex?@"YES":@"NO");
    NSLog(@"age --%ld",model.age);
    NSLog(@"height --%lf",model.height);
    NSLog(@"job --%@",model.job);
    
    NSLog(@"clothes.name --%@",model.clothes.name);
    NSLog(@"clothes.type --%@",model.clothes.type?@"YES":@"NO");
    NSLog(@"clothes.size --%ld",model.clothes.size);
    NSLog(@"clothes.width --%lf",model.clothes.width);
    
    for (Person* person in model.personList) {
        
        NSLog(@"person.name == %@",person.name);
        NSLog(@"person.age == %ld",person.age);
    }
    
}


- (void)modelWithArray
{
    NSDictionary* dict = [self getDict];
    
    NSArray* personList = [dict objectForKey:@"personList"];
    
    NSArray* modelList = [Person ls_modelArrayWithArray:personList];
    
    NSLog(@"modelList.count == %ld",modelList.count);
    
    for (Person* model in modelList) {
        NSLog(@"person.name == %@",model.name);
        NSLog(@"person.age == %ld",model.age);
    }
}


- (NSDictionary*)getDict
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:@"Dylan" forKey:@"name"];
    [dict setObject:[NSNumber numberWithBool:NO] forKey:@"sex"];
    [dict setObject:[NSNumber numberWithInteger:28] forKey:@"age"];
    [dict setObject:[NSNumber numberWithFloat:1.78] forKey:@"height"];
    [dict setObject:@"IOS" forKey:@"job"];
    
    NSMutableDictionary * clothes = [NSMutableDictionary dictionary];
    [clothes setObject:@"夏装" forKey:@"name"];
    [clothes setObject:[NSNumber numberWithBool:YES] forKey:@"type"];
    [clothes setObject:[NSNumber numberWithInteger:170] forKey:@"size"];
    [clothes setObject:[NSNumber numberWithFloat:0.58] forKey:@"width"];
    [dict setObject:clothes forKey:@"clothes"];
    
    
    NSMutableArray* personList = [NSMutableArray array];
    for (NSInteger i = 0; i<5; i++) {
        
        NSMutableDictionary * person = [NSMutableDictionary dictionary];
        
        [person setObject:[NSString stringWithFormat:@"小明%ld",i] forKey:@"name"];
        [person setObject:[NSNumber numberWithBool:YES] forKey:@"sex"];
        [person setObject:[NSNumber numberWithInteger:23+i] forKey:@"age"];
        [personList addObject:person];
    }
    
    [dict setObject:personList forKey:@"personList"];
    
    return dict;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listData.count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"cellIdentifier";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    cell.textLabel.text = listData[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
            [self modelWithDictionary];
        }
            break;
        case 1:{
            
            [self modelWithArray];
        }
            break;
            
        default:
            break;
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
