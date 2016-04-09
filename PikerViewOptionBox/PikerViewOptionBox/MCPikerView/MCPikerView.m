//
//  MCPikerView.m
//
//
//  Created by Marc on 16/2/25.
//
//
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define BLUECOLOR [UIColor colorWithRed:56/255.0 green:139/255.0 blue:251/255.0 alpha:1.0]

#import "MCPikerView.h"
#pragma mark - WZSelectionItems

@interface MCclickedItems : NSObject <MCClickedItmesProtocol>

@property (nonatomic, strong) NSMutableArray *itemsArray;
- (NSInteger) count;

@end


@implementation MCclickedItems

- (instancetype)init{
    self = [super init];
    if (self) {
        self.itemsArray = [NSMutableArray array];
    }
    return self;
}


- (void)addItemsWithPikerView:(NSArray *)ary {
    [self.itemsArray addObject:ary];
}

- (NSInteger)count{
    return self.itemsArray.count;
}

@end
#pragma mark - MCPikerView
@interface MCPikerView () <UIPickerViewDataSource,UIPickerViewDelegate> {
    UIPickerView *myPicker;
}
@property (nonatomic, strong)UIImageView *dateBK;
@property (nonatomic, strong)MCclickedItems *items;
@property (nonatomic, copy) void (^clickedBlock)(NSInteger clickedButton);

@end
@implementation MCPikerView

- (instancetype)initWithFrame:(CGRect)frame {
    self =  [super initWithFrame:frame];
    if (self) {
    
        UIWindow *grayBK = [[UIApplication sharedApplication] keyWindow];
        self.frame = grayBK.bounds;
        
        
//         [self viewController];
        
        UIView *gesView = [[UIView alloc] initWithFrame:self.bounds];
        gesView.backgroundColor = [UIColor clearColor];
        [gesView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSelf)]];
        [self addSubview:gesView];

       self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];

        
        _dateBK = [[UIImageView alloc] initWithFrame:CGRectMake(0,ScreenHeight, ScreenWidth, 240)];
        _dateBK.backgroundColor = [UIColor whiteColor];
        _dateBK.userInteractionEnabled = YES;
        [self addSubview:_dateBK];
        
        myPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 24, ScreenWidth, 216)];
//        myPicker.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bk_end"]];
        myPicker.backgroundColor =  [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        myPicker.dataSource = self;
        myPicker.delegate = self;
        [_dateBK addSubview:myPicker];
        
        //初始化选中的数
        UIImageView *endView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 24)];
        endView.userInteractionEnabled = YES;
        endView.image = [UIImage imageNamed:@"bk_top"];
        [_dateBK addSubview:endView];
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(0, 0, 50, 24);
        [leftButton setTitleColor:BLUECOLOR forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        leftButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [leftButton addTarget:self action:@selector(changeleftAction:) forControlEvents:UIControlEventTouchUpInside];
        [leftButton setTitle:@"取消" forState:UIControlStateNormal];
        [endView addSubview:leftButton];
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = CGRectMake(ScreenWidth-50, 0, 50, 24);
        [rightButton setTitleColor:BLUECOLOR forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        rightButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [rightButton addTarget:self action:@selector(changeRightAction:) forControlEvents:UIControlEventTouchUpInside];
        [rightButton setTitle:@"确定" forState:UIControlStateNormal];
        [endView addSubview:rightButton];

    }
    return self;
}

#pragma mark - PikerView delegate & datasource
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.items.count;
}


- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.items.itemsArray[component] count];
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return  32;
}

- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return  ScreenWidth /self.items.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    //思想就是：先创建一个View以指定列的宽度，和所在列行的高度，为尺寸
    //再建立一个label,在这个view上显示字体，字体颜色，字体大小，然后，把这个label添加到view中
    //返回view，作为指定列的每行的视图

    //取得指定列的宽度
    CGFloat width=[self pickerView:pickerView widthForComponent:component];
    //取得指定列，行的高度
    CGFloat height=[self pickerView:pickerView rowHeightForComponent:component];
    //定义一个视图
    UIView *myView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    //指定视图frame
    UILabel *labelOnComponent=[[UILabel alloc] initWithFrame:myView.frame];
    labelOnComponent.textAlignment = NSTextAlignmentCenter;
    labelOnComponent.text = [self.items.itemsArray[component] objectAtIndex:row];
    labelOnComponent.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];

    [myView addSubview:labelOnComponent];

 
    
    return myView;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    //取得选择的是第0列的哪一行
//    NSInteger rowOfFontComponent = [pickerView selectedRowInComponent:0];
   
    //最后将所选择的结果展现在label上，即字体样式，字体颜色，字体大小
    //NSLog(@"结果 == %@",label.text);
//    yyText.text = label.text;
}
#pragma mark - Publick Mehtod
+ (void)showWithItemsBlock:(void (^)(id <MCClickedItmesProtocol>items))itemsBlock
              clickedBlock:(void (^)(NSInteger clickedIndex))clickedBlock {
    MCPikerView *pikerView = [[MCPikerView alloc] initWithFrame:CGRectZero];
    [pikerView showWithItemsBlock:itemsBlock clickedBlock:clickedBlock];
    
}
- (void)showWithItemsBlock:(void (^)(id <MCClickedItmesProtocol>items))itemsBlock
              clickedBlock:(void (^)(NSInteger clickedIndex))clickedBlock{

    self.clickedBlock =clickedBlock;
    itemsBlock(self.items);
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    self.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.dateBK.frame;
        frame.origin.y = ScreenHeight-240;
        self.dateBK.frame = frame;
    }];
    
    
    
}
#pragma mark - IBAction
//预约时间左边的按钮
- (void)changeleftAction:(UIButton *)sender{
    [self hideSelf];
}

//预约时间右边的按钮
- (void)changeRightAction:(UIButton *)sender{
    for (int i = 0; i < self.items.count; i++) {
        NSInteger row =[myPicker selectedRowInComponent:i];
        self.clickedBlock(row);
    }
    [self hideSelf];
}

- (void)hideSelf{
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        CGRect frame = self.dateBK.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.dateBK.frame = frame;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
        
    }];
}
#pragma mark - Getter
- (MCclickedItems *)items{
    if (!_items) {
        _items = [[MCclickedItems alloc] init];
    }
    return _items;
}

@end
