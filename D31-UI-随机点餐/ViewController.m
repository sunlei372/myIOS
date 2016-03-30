//
//  ViewController.m
//  D31-UI-随机点餐
//
//  Created by 孙磊 on 16/3/29.
//  Copyright © 2016年 sunlei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *fruitLab;
@property(weak,nonatomic)IBOutlet UILabel *maincourseLab;
@property(weak,nonatomic)IBOutlet UILabel*drinksLab;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property(nonatomic,strong)NSArray *dataArray;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
   
    //设置代理
    self.pickerView.dataSource=self;
    self.pickerView.delegate=self;
    //页面加载时默认选择第一个
    for (int i=0; i<self.dataArray.count; i++) {
     [self pickerView:self.pickerView didSelectRow:0 inComponent:i];
    }
    
}

#pragma mark- 组
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.dataArray.count;
}


#pragma mark- 行
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *rowArray=self.dataArray[component];
    return rowArray.count;
}


#pragma mark- 每行内容
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    NSArray *tempArray=self.dataArray[component];
    return tempArray[row];
}

#pragma mark- 选择
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"%ld--%ld",(long)row,(long)component);
//    for (int i=0; i<_dataArray.count; i++) {
//        
//    }
    if (component==0) {
        self.fruitLab.text=_dataArray[0][row];
    }else if(component==1)
    {
        self.maincourseLab.text=_dataArray[1][row];
    }else{
        self.drinksLab.text=_dataArray[2][row];
    }
}

#pragma 随机点餐按钮
- (IBAction)randomClick:(UIButton *)sender {
    
    for (int i=0; i<_dataArray.count; i++) {
        //随机数
        u_int32_t random=arc4random_uniform((int)[_dataArray[i] count]);
        [self.pickerView selectRow:random inComponent:i animated:YES];
        //让lable改变
        [self pickerView:self.pickerView didSelectRow:random inComponent:i];
    }
    
}

#pragma mark- 懒加载
-(NSArray *)dataArray
{
    if (_dataArray==nil) {
        NSString *strPath=[[NSBundle mainBundle]pathForResource:@"01foods.plist" ofType:nil];
        NSArray *tempArray=[NSArray arrayWithContentsOfFile:strPath];
        _dataArray=tempArray;
    }
    return _dataArray;
}


@end
