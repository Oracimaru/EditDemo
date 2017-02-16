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
@interface XRSAddTicketCell :UITableViewCell {
    
    UILabel       *titleLabel;
    UIImageView   *imageview;
    
}
@property (nonatomic, copy) void (^onEvent)(id classData);

@end

@implementation XRSAddTicketCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customInit];
    }
    return self;
}

-(void)customInit{
   
    imageview = ({
        UIImageView * imgView = [[UIImageView alloc]init];
        imgView.image = [UIImage imageNamed:@"ticket"];
        [self.contentView addSubview:imgView];
        imgView;
    });
    
    
    titleLabel = ({
        UILabel *tLabel = [[UILabel alloc] init];
        tLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
        tLabel.font = [UIFont systemFontOfSize:24];
        tLabel.text = @"录入优惠券";
        [self.contentView addSubview:tLabel];
        tLabel;
    });
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    [titleLabel   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageview.mas_right).offset(10);
        make.centerY.equalTo(self.contentView);
    }];
   
    [ imageview   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.width.height.equalTo(@20);
        make.centerY.equalTo(self.contentView);
    }];
    
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    
}
- (void)cellForData:(id )cellData {
    
}
- (void)buttonPressed:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
            if(self.onEvent){
                self.onEvent(@{@"event":@"bookdownload",@"data":@""});
            }
            break;
            
        default:
            break;
    }
    
}
@end

@interface XRSTicketCell : UITableViewCell {
    
    UIView *realContentView;
    UIButton *selectButton;
    UIImageView * backImageView;//上半部分
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
        self.backgroundColor = RGB(238, 238, 238);
        [self customInit];
    }
    return self;
}
- (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
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
        rView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:rView];
        rView;
    });
    backImageView = ({
        UIImageView * imgView = [[UIImageView alloc]init];
        imgView.image = [self imageWithColor:[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1]];
        [realContentView addSubview:imgView];
        imgView;
    });
    
    
    priceLabel = ({
        UILabel *tLabel = [[UILabel alloc] init];
        tLabel.textColor = [UIColor blackColor];
        tLabel.font = [UIFont systemFontOfSize:40];
        tLabel.text = @"¥50";
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
        tLabel.textColor = [UIColor lightGrayColor];
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
- (void)layoutSubviews
{
    [super layoutSubviews];
    [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView);
    }];
   
    [realContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (isEdit) {
            make.left.equalTo(self.contentView).offset(45);
        }else{
            make.left.equalTo(self.contentView).offset(15);
        }
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(realContentView);
        make.height.equalTo(@132);
    }];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(realContentView).offset(14);
        make.centerY.equalTo(backImageView);
    }];

    [ticketLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(realContentView).offset(-10);
        make.top.equalTo(realContentView).offset(5);
    }];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel);
        make.centerY.equalTo(backImageView).offset(-10);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(priceLabel.mas_right).offset(20);
        make.centerY.equalTo(backImageView).offset(10);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(realContentView);
        make.bottom.equalTo(backImageView);
        make.height.equalTo(@1);
    }];
    [useLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(realContentView);
        make.bottom.equalTo(backImageView).offset(-17);
    }];

    [arowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(useLabel.mas_right).offset(6);
        make.bottom.equalTo(useLabel);
        make.size.mas_equalTo(CGSizeMake(15, 14));
    }];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(realContentView).offset(13);
        make.right.equalTo(realContentView).offset(-13);
        make.top.equalTo(backImageView.mas_bottom).offset(11);
    }];
    [sealView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(realContentView).offset(-11);
        make.top.equalTo(realContentView).offset(11);
    }];
    MASAttachKeys(realContentView,realContentView);
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    isEdit = editing;
    [realContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (isEdit) {
            make.left.equalTo(self.contentView).offset(45);
            make.right.equalTo(self.contentView).offset(15);

        }else{
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
        }
        make.top.bottom.equalTo(self.contentView);


    }];
    [UIView animateWithDuration:0.3 animations:^{
        [self.contentView layoutIfNeeded];
        
    }];
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

@interface XRSTicketViewController ()<UITableViewDataSource, UITableViewDelegate,SMPagerTabViewDelegate>{
    
    UITableView * XRSTicketTableView;
    UITableView * XRSUsedTableView;
    SMPagerTabView *segmentView;
    NSMutableArray *allViews;
    NSMutableArray *allTitles;

    UIView *bottomView;
    UIButton *selectButton;
    UILabel * selectLabel;
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
        UITableView *dTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        dTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        dTable.delegate = self;
        dTable.dataSource = self;
        dTable.backgroundColor = RGB(238, 238, 238);
        dTable.separatorColor = UIBGCOLOR_238;
        dTable;
    });
    XRSUsedTableView = ({
        UITableView *dTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        dTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        dTable.delegate = self;
        dTable.dataSource = self;
        dTable.backgroundColor = RGB(238, 238, 238);
        dTable.separatorColor = UIBGCOLOR_238;
        dTable;
    });
    segmentView = ({
        SMPagerTabView* segView = [[SMPagerTabView alloc]
                                   initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
//        segView.backgroundColor = [UIColor blueColor];
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
        bView.backgroundColor = [UIColor whiteColor];
        bView;
    });
    
   
    selectButton = ({
        UIButton *sButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sButton.frame = CGRectMake(0, 0, 40, 40);
        [sButton setImage:[UIImage imageNamed:@"study_unselected"] forState:UIControlStateNormal];
        [sButton setImage:[UIImage imageNamed:@"study_selected"] forState:UIControlStateSelected];
        [sButton addTarget:self action:@selector(buttonSelect:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:sButton];
        [sButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@15);
            make.left.equalTo(bottomView).offset(15);
            make.centerY.equalTo(bottomView);
        }];

        sButton;
    });
    selectLabel = ({
        UILabel *tLabel = [[UILabel alloc] init];
        tLabel.textColor = [UIColor lightGrayColor];
        tLabel.font = [UIFont systemFontOfSize:18];
        tLabel.text = @"全选";
        [bottomView addSubview:tLabel];
        [tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(selectButton.mas_right).offset(10);
            make.centerY.equalTo(selectButton);
        }];
        tLabel;
    });

    deleteButton = ({
        UIButton *dButton = [UIButton buttonWithType:UIButtonTypeCustom];
        dButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [dButton setBackgroundColor:[UIColor colorWithRed:1 green:0.36 blue:0.35 alpha:1]];
        [dButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [dButton setTitle:@"解绑并删除" forState:UIControlStateNormal];
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
    deleteButton.frame = CGRectMake(bottomView.width - 157, 0, 157, bottomView.height);
    
}
-(void)addRightButton
{
    editButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 40)];
    [editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    editButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
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
#pragma mark  -- 暂时用于兑换优惠券
- (void)deleteSelect
{
    
}
- (void)buttonSelect:(UIButton*)sender
{
    UIButton *button = (UIButton *)sender;
    button.selected = !button.isSelected;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 48;
    }
    return 203.0f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:
        {
            XRSAddTicketCell *cell= [tableView dequeueReusableCellWithIdentifier:
                                 NSStringFromClass([XRSAddTicketCell class])];
            if(!cell){
                cell= [[XRSAddTicketCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:
                       NSStringFromClass([XRSAddTicketCell class])];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
           
            return cell;
            break;
        }
            
        default: {
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
            break;
        }
            
    }
    return 0;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    DTSelectCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0){
        //录入优惠券入口
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
