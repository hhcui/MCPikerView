# MCPikerView

---

常用的PikerView选择器
 
###示例图

![PikerviewImage](http://cuihh.cn/wp-content/uploads/2016/04/pikerview.png)

###控件特性

	使用简单，代码高聚合，block管理数据源，
	
###使用方式

    NSArray *ary = @[@"123",@"123",@"123"];
    
    [MCPikerView showWithItemsBlock:^(id<MCClickedItmesProtocol> items) {
        [items addItemsWithPikerView:ary];
    } clickedBlock:^(NSInteger clickedIndex) {
        NSLog(@"选中第%d数据源",clickedIndex);
    }];


