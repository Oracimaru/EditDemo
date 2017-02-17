//
//  XRSTicketViewController.m
//  EditDemo
//
//  Created by EOS on 17/2/14.
//  Copyright © 2017年 zhanghaibin. All rights reserved.
//

#import "XRSTicketViewController.h"
#import "Masonry.h"
#import "UIView+frameAdjust.h"
#import "DTInit.h"
#import "SMPagerTabView.h"
#import "XRSInputAlertView.h"

@interface XRSTicketCell : UITableViewCell {
    
    UIView *realContentView;
    UIButton *selectButton;
    UIView   *verticalLine;
    UILabel  *priceLabel;
    UILabel  *ticketLabel;
    UILabel  * dateLabel;
    UILabel *titleLabel;
    UIImageView * lineView;//虚线
    UILabel *useLabel;
    UIImageView * arowImageView;//箭头
    UILabel * contentLabel;
    UIImageView *sealView;//印章,戳
    BOOL isEdit;
    
}

@property (nonatomic, copy) void (^onSelect)(BOOL isSelect);

@end

@implementation XRSTicketCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customInit];
    }
    return self;
}

- (void)customInit {
    selectButton = ({
        UIButton *sButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sButton.frame = CGRectMake(0, 0, 40, 40);
        [sButton setImage:[UIImage imageNamed:@"study_unselected"] forState:UIControlStateNormal];
        [sButton setImage:[UIImage imageNamed:@"study_selected"] forState:UIControlStateSelected];
        [sButton addTarget:self action:@selector(buttonSelect:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:sButton];
        
        sButton;
    });
    
    realContentView = ({
        UIView *rView = [[UIView alloc] init];
        rView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:rView];
        rView;
    });
    verticalLine = ({
        UIView *rView = [[UIView alloc] init];
        rView.backgroundColor = [UIColor whiteColor];
        [realContentView addSubview:rView];
        rView;
    });
    
    priceLabel = ({
        UILabel *tLabel = [[UILabel alloc] init];
        tLabel.textColor = [UIColor blackColor];
        tLabel.font = [UIFont systemFontOfSize:18];
        tLabel.text = @"¥  100";
        [realContentView addSubview:tLabel];
        tLabel;
    });
    
    ticketLabel = ({
        UILabel *tLabel = [[UILabel alloc] init];
        tLabel.textColor = [UIColor lightGrayColor];
        tLabel.font = [UIFont systemFontOfSize:22];
        tLabel.text = @"优惠券";
        [realContentView addSubview:tLabel];
        tLabel;
    });
    dateLabel = ({
        UILabel *tLabel = [[UILabel alloc] init];
        tLabel.textColor = [UIColor lightGrayColor];
        tLabel.font = [UIFont systemFontOfSize:14];
        tLabel.text = @"2015/08/19-2016/09/12";
        [realContentView addSubview:tLabel];
        tLabel;
    });

    
    titleLabel = ({
        UILabel *tLabel = [[UILabel alloc] init];
        tLabel.textColor = [UIColor lightGrayColor];
        tLabel.font = [UIFont systemFontOfSize:14];
        tLabel.text = @"仅限于一个班级使用并按剩余课次结算";
        [realContentView addSubview:tLabel];
        tLabel;
    });
    lineView = ({
        UIImageView * imgView = [[UIImageView alloc]init];
        imgView.image = [UIImage imageNamed:@"虚线"];
        [realContentView addSubview:imgView];
        imgView;
    });
    useLabel = ({
        UILabel *tLabel = [[UILabel alloc] init];
        tLabel.textColor = [UIColor blackColor];
        tLabel.font = [UIFont systemFontOfSize:14];
        tLabel.text = @"使用规则";
        [realContentView addSubview:tLabel];
        tLabel;
    });
    contentLabel = ({
        UILabel *tLabel = [[UILabel alloc] init];
        tLabel.numberOfLines = 0;
        tLabel.textColor = [UIColor blackColor];
        tLabel.font = [UIFont systemFontOfSize:14];
        tLabel.text = @"适用于2015年春季班.活动类小心一年级,小学二年级,小学三年级,小学四年级,小学五年级英语,数学,语文";
        [realContentView addSubview:tLabel];
        tLabel;
    });

    arowImageView = ({
        UIImageView * imgView = [[UIImageView alloc]init];
        imgView.image = [UIImage imageNamed:@"向下"];
        [realContentView addSubview:imgView];
        imgView;
    });
    sealView = ({
        UIImageView * imgView = [[UIImageView alloc]init];
        imgView.image = [UIImage imageNamed:@"没中奖"];
        [realContentView addSubview:imgView];
        imgView;
    });
    
    
    isEdit = NO;
}
- (void)updateConstraints
{
    [super updateConstraints];
    [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(5);
        make.centerY.equalTo(self.contentView);
    }];
    [realContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (isEdit) {
            make.left.equalTo(self.contentView).offset(40);
        }else{
            make.left.equalTo(self.contentView);
        }
        make.top.right.bottom.equalTo(self.contentView);
    }];
    [verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(realContentView);
        make.top.bottom.equalTo(realContentView);
        make.width.equalTo(@2);
    }];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(realContentView).offset(5);
        make.top.equalTo(realContentView).offset(10);
    }];

    [ticketLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(realContentView).offset(-10);
        make.top.equalTo(realContentView).offset(5);
    }];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(realContentView).offset(-5);
        make.top.equalTo(ticketLabel.mas_bottom).offset(10);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(realContentView).offset(-5);
        make.top.equalTo(dateLabel.mas_bottom).offset(5);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(realContentView).offset(5);
        make.top.equalTo(titleLabel.mas_bottom).offset(5);
        make.height.equalTo(@1);
    }];
    [useLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(realContentView);
        make.bottom.equalTo(arowImageView.mas_top).offset(-5);
    }];

    [arowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(realContentView);
        make.bottom.equalTo(realContentView).offset(-5);
    }];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(realContentView).offset(5);
        make.bottom.equalTo(useLabel.mas_top).offset(-5);
        //make.top.equalTo(lineView.mas_bottom).offset(5).priorityLow();
    }];
    [sealView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(realContentView).offset(-40);
        make.top.equalTo(realContentView).offset(30);
    }];
    MASAttachKeys(realContentView,realContentView);
}
- (void)layoutSubviews {
    [super layoutSubviews];
//    realContentView.left = isEdit?40:0;
//    realContentView.width = self.contentView.width;
//    realContentView.height = self.contentView.height;
//    selectButton.centerY = self.contentView.height/2;
//    titleLabel.width = self.contentView.width - 10 - titleLabel.left;
//    titleLabel.centerY = self.contentView.centerY;
    
    
    
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    isEdit = editing;
    [realContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (isEdit) {
            make.left.equalTo(self.contentView).offset(40);
        }else{
            make.left.equalTo(self.contentView);
        }
        make.top.right.bottom.equalTo(self.contentView);

    }];
//    [UIView animateWithDuration:0.3 animations:^{
//       // realContentView.left = editing?40:0;
//        [self.contentView layoutIfNeeded];
//        
//    }];
}

- (void)buttonSelect:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.isSelected;
    //    if (self.onSelect) {
    //        self.onSelect(button.isSelected);
    //    }
//    _currentDownloadItem.isSelected = button.selected;
}

@end

@interface XRSTicketViewController ()<UITableViewDataSource, UITableViewDelegate,SMPagerTabViewDelegate,XRSInputAlertViewDelegate>{
    
    UITableView * XRSTicketTableView;
    UITableView * XRSUsedTableView;
    SMPagerTabView *segmentView;
    NSMutableArray *allViews;
    NSMutableArray *allTitles;

    UIView *bottomView;
    BOOL isEdit;
    NSInteger    selectedIndex;

    UIButton *editButton;
    UIButton *deleteButton;

    
}

@end

@implementation XRSTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.title = @"我的优惠券";
    isEdit = NO;

    [self.view addSubview:bottomView];
    [self addRightButton];
    [XRSTicketTableView reloadData];
}
- (void)loadView
{
    [super loadView];
        XRSTicketTableView = ({
        UITableView *dTable = [[UITableView alloc] init];
        dTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        dTable.delegate = self;
        dTable.dataSource = self;
        dTable;
    });
    XRSUsedTableView = ({
        UITableView *dTable = [[UITableView alloc] init];
        dTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        dTable.delegate = self;
        dTable.dataSource = self;
        dTable;
    });
    segmentView = ({
        SMPagerTabView* segView = [[SMPagerTabView alloc]
                                   initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
        //segView.backgroundColor = [UIColor blueColor];
        allTitles = [NSMutableArray arrayWithObjects:@"未使用",@"已使用", nil];
        allViews = [NSMutableArray arrayWithObjects:XRSTicketTableView,XRSUsedTableView, nil];
        segView.delegate = self;
        segView.containerView = self.view;
        segView.tabMargin = 0.01;
        [segView buildUI];
        [segView selectTabWithIndex:0 animate:NO];
        [self.view addSubview:segView];
        segView;
    });

    bottomView = ({
        UIView *bView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 48)];
        bView.backgroundColor = [UIColor lightGrayColor];
        bView;
    });
    deleteButton = ({
        UIButton *dButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [dButton setBackgroundColor:UITEXTCOLOR_TITLE];
        dButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [dButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [dButton setTitle:@"解绑" forState:UIControlStateNormal];
        [dButton addTarget:self action:@selector(deleteSelect) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:dButton];
        dButton;
    });

}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (isEdit) {
        bottomView.frame = CGRectMake(0, self.view.height- bottomView.height, self.view.width, bottomView.height);
        segmentView.bodyScrollView.frame = CGRectMake(0, segmentView.height, self.view.width, self.view.height - bottomView.height-segmentView.height);

    } else {
        bottomView.frame = CGRectMake(0, self.view.height , self.view.width, bottomView.height);
        segmentView.bodyScrollView.frame = CGRectMake(0, segmentView.height, self.view.width, self.view.height  - segmentView.height);

    }
    deleteButton.frame = CGRectMake(bottomView.width - 80, 0, 80, bottomView.height);

}
-(void)addRightButton
{
    editButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 40)];
    [editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [editButton setTitleColor:RGB(50, 161, 240) forState:UIControlStateNormal];
    editButton.titleLabel.font = [UIFont systemFontOfSize:14];
    editButton.titleEdgeInsets  = UIEdgeInsetsMake(0, 0, 0, -10);
    [editButton addTarget:self action:@selector(startEdit) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:editButton];
    self.navigationItem.rightBarButtonItem =  rightItem;
}
#pragma mark - DBPagerTabView Delegate
- (NSUInteger)numberOfPagers:(SMPagerTabView *)view {
    return [allViews count];
}
- (UIView *)pagerViewOfPagers:(SMPagerTabView *)view indexOfPagers:(NSUInteger)number {
    return allViews[number];
}

- (NSString *)titleOfPagers:(SMPagerTabView *)view indexOfPagers:(NSUInteger)number
{
    return allTitles[number];
}
- (void)whenSelectOnPager:(NSUInteger)number {
    NSLog(@"页面 %lu",(unsigned long)number);
    selectedIndex  = number;
    if (number == 0) {
    }else{
//        [self loadPurchasedData:YES];
    }
}
#pragma mark -- event action
- (void)startEdit {
    isEdit = !isEdit;
    
    if (isEdit) {
        bottomView.bottom = self.view.height;

    } else {
        bottomView.top = self.view.height;

    }
    segmentView.bodyScrollView.height = bottomView.top  ;
    [segmentView setNeedsLayout];
    deleteButton.centerY = bottomView.centerY;

    [editButton setTitle:isEdit?@"完成":@"编辑" forState:UIControlStateNormal];
    XRSTicketTableView.editing = isEdit;
}

- (void)inputPromoCode
{
    XRSInputAlertView *inputAlertview = [[XRSInputAlertView alloc] initWithTitle:@"请输入您的优惠券码" delegate:self message:nil confirmButton:@"确认兑换"];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:inputAlertview];
}

- (void)deleteSelect
{
    
}

#pragma mark xrsInputAlertViewDelegate
- (void)xrsInputAlertView:(XRSInputAlertView *)inputAlertView clickedButtonWithContent:(NSString *)content
{
    NSLog(@"优惠券码：%@",content);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
            XRSTicketCell *cell= [tableView dequeueReusableCellWithIdentifier:
                                 NSStringFromClass([XRSTicketCell class])];
            if(!cell){
                cell= [[XRSTicketCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:
                       NSStringFromClass([XRSTicketCell class])];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
//            if (!_dataArray.exsit) {
//                return cell;
//            }
    
//            DTGoodsDetail *detail = self.activityData.list[indexPath.row];
//            [cell cellForData:detail];
    
            return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    DTSelectCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
