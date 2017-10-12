//
//  DTCViewController.m
//  FuelPak BLE
//
//  Created by Mike Saradeth on 9/21/17.
//  Copyright © 2017 Mike Saradeth. All rights reserved.
//

#import "DTCViewController.h"
#import <FuelPak_BLE-Swift.h>

//#import <TestSwift-Swift.h>
//#import <ProductName/ProductModuleName-Swift.h>

#define MinCellHeight 94.0

@interface DTCViewController ()

@end

@implementation DTCViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    
    if (Bike.sharedInstance.isDemoMode) {
           [self readDtcShortDescriptionFromFile];
    }else {
        [self addObservers];
        [self sendReadDtcCommands:0];        
    }
    
    
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    self readDtcShortDescriptionFromFile];
//    [self updateTheme];
}


- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Init
- (void) initData
{
    listOfItems = [[NSMutableArray alloc] init];
 
}


- (IBAction)refreshButton:(id)sender {
    [self sendReadDtcCommands:0];
}


- (IBAction)clearButton:(id)sender {
    
}

#pragma mark - UITableView Methods
//func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//    var sectionTitle: String
//    if (Bike.sharedInstance.isDemoMode == true) {
//        sectionTitle = "Status:  Demo Mode"
//    }else {
//        if (Bike.sharedInstance.isConnected) {
//            sectionTitle = "Status:  Connected"
//        }else {
//            sectionTitle = "Status:  Disconnected"
//        }
//    }
//
//
//
//
//    return sectionTitle
//}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle;
    if (Bike.sharedInstance.isDemoMode == true) {
        sectionTitle = @"Status:  Demo Mode";
    }else {
        if (Bike.sharedInstance.isConnected) {
            sectionTitle = @"Status:  Connected";
        }else {
            sectionTitle = @"Status:  Disconnected";
        }
    }
    
    return sectionTitle;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger nCount;
    nCount = [listOfItems count];
    return nCount;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MinCellHeight;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MinCellHeight;
    
//    return UITableViewAutomaticDimension;
    
    
    
//    //return ( [[EAController sharedController] getCellHeight] );
//    
//    TCCellData *cellData = listOfItems[[indexPath row]];
//    if (cellData.isParent) {
//        return ( [[EAController sharedController] getCellHeight] );
//        
//    }else {
//        
//        NSString    *text;
//        NSInteger   ncount;
//        float       fval;
//        unsigned int divisor;
//        unsigned int ipadmultiplier;
//        
//        text = cellData.troubleCodeDescriptionDetail;
//        ncount = [text length];
//        
//        
//        ipadmultiplier =1.0;
//        NSString *deviceType = [UIDevice currentDevice].model;
//        if([deviceType isEqualToString:@"iPad"])
//        {
//            ipadmultiplier = 4;
//        }
//        
//        
//        fval = 0;
//        
//        if (currinterfaceOrientation==1 || currinterfaceOrientation==2)
//        {
//            divisor = 30*ipadmultiplier;
//        }
//        
//        
//        if (currinterfaceOrientation==3 || currinterfaceOrientation==4)
//        {
//            divisor = 60*ipadmultiplier;
//        }
//        
//        
//        fval = fval + [[EAController sharedController] getCellTextLabelFontSize]*2.0 +  ([[EAController sharedController] getCellTextLabelFontSize] * ((ncount / divisor)+2) );
//        
//        //NSLog(@"%ld %ld %f", index, ncount, fval  );
//        //Parent cell height is the Minimum height for child cells
//        if (fval < [[EAController sharedController] getCellHeight] ) {
//            return [[EAController sharedController] getCellHeight];
//        }else {
//            return fval;
//        }
//    }
    
    
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    cell.backgroundColor =[[EAController sharedController] getCellBackgroundColor];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //static NSString *CellIdentifier = @"Cell";
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cells%ld", (long)[indexPath row] ];
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:CellIdentifier];
        [self.cellPtr addObject:cell];
        CAGradientLayer *gradient = [CAGradientLayer layer];
//        gradient.frame = CGRectMake(0, 0, [[EAController sharedController] getMaxScreenSize], 93/2); //cell.bounds;
        gradient.colors = [NSArray arrayWithObjects:(id)[[[UIColor alloc] initWithRed:0.120 green:0.118 blue:0.118 alpha:1.0]CGColor],(id)[[UIColor clearColor]CGColor], (id)[[UIColor clearColor]CGColor],(id)[[UIColor clearColor]CGColor], (id)[[UIColor clearColor]CGColor], nil];
        //  [gradient setStartPoint:CGPointMake(0.0, 0.5)];
        //  [gradient setEndPoint:CGPointMake(1.0, 0.5)];
        [cell.layer addSublayer:gradient];
        
        // }
        
        // Set up the cell...
        
        cell.detailTextLabel.numberOfLines = 0;
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        
//        // Set up the cell...
//        //cell.textLabel.text     =  listOfItems[[indexPath row]];
//        cell.textLabel.font     = [UIFont fontWithName:[[EAController sharedController] getCellTextLabelFontName] size:[[EAController sharedController] getCellTextLabelFontSize]];
//        cell.textLabel.opaque   = [[EAController sharedController] getCellTextLabelOpaque];
//        cell.textLabel.textColor        = [[EAController sharedController] getActiveTextLabelTextColor];
//        //cell.textLabel.textColor        = [[EAController sharedController] getCellDetailTextLabelTextColor ];
//        cell.textLabel.backgroundColor  = [[EAController sharedController] getCellTextLabelBackgroundColor];
//        cell.detailTextLabel.textColor = [[EAController sharedController] getCellDetailTextLabelTextColor];
//        //cell.detailTextLabel.textColor = [[EAController sharedController] getActiveTextLabelTextColor ];
//        cell.detailTextLabel.backgroundColor = [[EAController sharedController] getCellDetailTextLabelBackgroundColor];
//        cell.detailTextLabel.font = [UIFont fontWithName:[[EAController sharedController] getCellDetailTextLabelFontName] size:[[EAController sharedController] getCellDetailTextLabelFontSize] ];
//        
//        
//        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[[EAController sharedController] getCellSelectedBackgroundView]  ]];
//        cell.textLabel.highlighted  = [[EAController sharedController] getCellSelectedTextLabelTextColor];
        
    }
    
    TCCellData *cellData = listOfItems[[indexPath row]];
    if (cellData.isParent) {
        //Set parent cell
        cell.textLabel.text = cellData.troubleCode;
        cell.imageView.image = cellData.icon;
        cell.detailTextLabel.text = cellData.troubleCodeDescription;
//        cell.detailTextLabel.textColor = [[EAController sharedController] getCellDetailTextLabelTextColor];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        
    }else {
        
        //Set child cell
        cell.textLabel.text = nil;
        cell.imageView.image = nil;
        cell.detailTextLabel.text = cellData.troubleCodeDescriptionDetail;
//        cell.detailTextLabel.textColor = [UIColor lightTextColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return cell;
    
}



//// Customize the appearance of table view cells.
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSArray  *descarray;
//    NSString *desc;
//    NSString *key;
//    NSInteger row;
//
//    //static NSString *CellIdentifier = @"Cell";
//
//    NSString *CellIdentifier = [NSString stringWithFormat:@"Cells%ld", (long)[indexPath row] ];
//
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:CellIdentifier];
//        [self.cellPtr addObject:cell];
//        CAGradientLayer *gradient = [CAGradientLayer layer];
//        gradient.frame = CGRectMake(0, 0, [[EAController sharedController] getMaxScreenSize], 93/2); //cell.bounds;
//        gradient.colors = [NSArray arrayWithObjects:(id)[[[UIColor alloc] initWithRed:0.120 green:0.118 blue:0.118 alpha:1.0]CGColor],(id)[[UIColor clearColor]CGColor], (id)[[UIColor clearColor]CGColor],(id)[[UIColor clearColor]CGColor], (id)[[UIColor clearColor]CGColor], nil];
//        //  [gradient setStartPoint:CGPointMake(0.0, 0.5)];
//        //  [gradient setEndPoint:CGPointMake(1.0, 0.5)];
//        [cell.layer addSublayer:gradient];
//
//   // }
//
//    // Set up the cell...
//
//    cell.detailTextLabel.numberOfLines = 0;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//
//    // Set up the cell...
//    cell.textLabel.text     =  listOfItems[[indexPath row]];
//    cell.textLabel.font     = [UIFont fontWithName:[[EAController sharedController] getCellTextLabelFontName] size:[[EAController sharedController] getCellTextLabelFontSize]];
//    cell.textLabel.opaque   = [[EAController sharedController] getCellTextLabelOpaque];
//    cell.textLabel.textColor        = [[EAController sharedController] getActiveTextLabelTextColor];
//    //cell.textLabel.textColor        = [[EAController sharedController] getCellDetailTextLabelTextColor ];
//    cell.textLabel.backgroundColor  = [[EAController sharedController] getCellTextLabelBackgroundColor];
//    cell.detailTextLabel.textColor = [[EAController sharedController] getCellDetailTextLabelTextColor];
//    //cell.detailTextLabel.textColor = [[EAController sharedController] getActiveTextLabelTextColor ];
//    cell.detailTextLabel.backgroundColor = [[EAController sharedController] getCellDetailTextLabelBackgroundColor];
//    cell.detailTextLabel.font = [UIFont fontWithName:[[EAController sharedController] getCellDetailTextLabelFontName] size:[[EAController sharedController] getCellDetailTextLabelFontSize] ];
//
//
//    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[[EAController sharedController] getCellSelectedBackgroundView]  ]];
//    cell.textLabel.highlighted  = [[EAController sharedController] getCellSelectedTextLabelTextColor];
//
//    row = [indexPath row];
//
//    key = listOfItems[row];
//    descarray = [self.dtcdict objectForKey:key];
//    desc = descarray[0];
//
//
//    if ( desc == nil )
//    {
//        desc= localeNotFound;
//    }
//
//    cell.detailTextLabel.text = desc;
//    }
//
//    return cell;
//
//}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    TCCellData *cellData = [listOfItems objectAtIndex:[indexPath row]];
    
    if (cellData.isParent){
        cellData.indexPath = indexPath;
        cellData.row = [indexPath row];
        if ([cellData.childItems count] == 0) {
            //            [self loadTroubleCodeDescriptionDetailAsyncTask:cellData];
            [self getDtcDescription:cellData];
        }else {
            [self updateUI:cellData];
        }
        
    }
}



//Expand or collapse given parent row depending on the row state
-(void) updateUI:(TCCellData *) cellData
{
    
    if (cellData.isExpanded) {
        
        //Set parent cell to NOT Expanded form
        cellData.isExpanded = NO;
        cellData.icon = [UIImage imageNamed: @"nav_right"];
        [listOfItems replaceObjectAtIndex:cellData.row withObject:cellData];
        
        //collapse Child data
        [self collapseSubItemsAtParentRow:cellData];
        
    }else {//is Not expanded, expand child table
        
        //Set parent cell to Expanded form
        cellData.isExpanded = YES;
        cellData.icon = [UIImage imageNamed: @"nav_down"];
        [listOfItems replaceObjectAtIndex:cellData.row withObject:cellData];
        
        //expand Child data
        [self expandItemAtParentRow:cellData];
        
        
    }
    
    //Reload parent cell in with correct arrow image
    [self.tableView reloadRowsAtIndexPaths:@[cellData.indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}



//Expand child items of a given parent
-(void)expandItemAtParentRow:(TCCellData*) cellData{
    
    //Do nothing if array is empty
    if ([cellData.childItems count] == 0)
        return;
    
    [self.tableView beginUpdates];
    
    NSMutableArray *arrChild = [[NSMutableArray alloc] init];   //initialize child array for a given parent
    
    int childRow = cellData.row;
    for (int ii = 0; ii < [cellData.childItems count]; ii++) {
        
        //Get cell data for child (subitem)
        TCCellData *cellChild = [[TCCellData alloc] initChild:cellData.childItems[ii]];
        
        childRow++;
        //Add child rows to be added to UI
        [arrChild addObject:[NSIndexPath indexPathForRow:childRow inSection:0]];
        
        //Add child row to Array
        [listOfItems insertObject:cellChild atIndex:childRow];
        
        
    }
    //Add children of given parent from UI
    [self.tableView insertRowsAtIndexPaths:arrChild withRowAnimation:UITableViewRowAnimationFade];
    
    [self.tableView endUpdates];
    
}


//Collapse child items of a given parent
- (void)collapseSubItemsAtParentRow:(TCCellData*) cellData{
    
    //Do nothing if array is empty
    if ([cellData.childItems count] == 0)
        return;
    
    [self.tableView beginUpdates];
    
    NSMutableArray *arrChild = [[NSMutableArray alloc] init];   //initialize child array for a given parent
    int childRow = cellData.row;
    for (int ii = 0; ii < [cellData.childItems count]; ii++) { //Loop until there is no more data in array childItems which contains suggested solution
        childRow++;
        //Add child rows to be deleted from UI
        [arrChild addObject:[NSIndexPath indexPathForRow:childRow inSection:0]];
        
        //Remove child row from Array
        [listOfItems removeObjectAtIndex:childRow];
        
    }
    //Delete children of given parent from UI
    [self.tableView deleteRowsAtIndexPaths:arrChild withRowAnimation:UITableViewRowAnimationFade];
    
    [self.tableView endUpdates];
    
}


#pragma mark - Read plist file - To get Trouble Code Short Description

- (void) readDtcShortDescriptionFromFile
{
    TCCellData *tmpCellData;
    NSString *troubleCode;
    NSString *codeShortDescription;

//    
//    NSDictionary *dtcDictionary;
//    dtcDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dtcShortDescription" ofType:@"plist"]];
//    for(NSString *key in [dtcDictionary allKeys]) {
//        NSLog(@"%@   %@ ", key, [dtcDictionary objectForKey:key]);
//    }
    
    
    if ( self.dtcdict == nil )
    {

        self.dtcdict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dtc_generic" ofType:@"plist"]];  //[[NSMutableArray alloc] initWithContentsOfFile:path];
        
        for(NSString *key in [self.dtcdict allKeys]) {
//            NSLog(@"%@   %@ ", key, [self.dtcdict objectForKey:key]);
            
            troubleCode = key;
            codeShortDescription = [self.dtcdict objectForKey:troubleCode];
            
            tmpCellData = [[TCCellData alloc]initWithTroubleCode:troubleCode troubleCodeDescription:[self getTroubleCodeDescription:troubleCode]];
            [listOfItems addObject:tmpCellData];
        }
        
        


    }
}


#pragma mark - Get DTC Description

-(NSString*) getTroubleCodeDescription:(NSString*) troubleCode {
    NSArray  *descarray;
    NSString *desc;
    
    descarray = [self.dtcdict objectForKey:troubleCode];
    desc = descarray[0];
    
    if ( desc == nil )
    {
        desc= localeNotFound;
    }
    
    return desc;
}




- (void) getDtcDescription:(TCCellData*)cellData;
{
        //set data (trouble code long descriptiob
    currCellData = cellData;
    NSString *troubleCodeLongDescription = @"Not Available.";
    currCellData.troubleCodeDescriptionDetail = troubleCodeLongDescription;
    [currCellData.childItems addObject:troubleCodeLongDescription];
    
    [self updateUI:currCellData];
    
//    NSString *urlServer;
//    currCellData = cellData;
//    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
//    [params setObject:@"DTC" forKey:@"method"];
//    [params setObject:cellData.troubleCode forKey:@"code"];
//    urlServer = [NSString stringWithFormat:@"%@",[[EAController sharedController] getServer]];
//    
//    HTTPRequestHelper *client = [[HTTPRequestHelper alloc] initWithTarget:self selector:@selector(dataDidReceivedDtcDescription:) errselector:@selector(dataDidReceivedError:)];
//    [client get:urlServer params:params];
    
}


- (void) dataDidReceivedDtcDescription:(id)data
{
//    NSString *troubleCodeLongDescription;
//    
//    //Parse Json Object
//    NSDictionary *jsonObject = [data objectFromJSONString];
//    NSDictionary *message = jsonObject[@"message"];
//    if ([jsonObject[@"status"] isEqualToString:@"success"]) {
//        troubleCodeLongDescription = message[@"description"];
//    }else if ([jsonObject[@"status"] isEqualToString:@"error"]) {
//        troubleCodeLongDescription = message[@"description"];
//    }
//    
//    if ([troubleCodeLongDescription length]==0 || troubleCodeLongDescription==nil) {
//        troubleCodeLongDescription = NSLocalizedStringFromTableInBundle(@"no_additional_info", nil, langBundle, nil);
//    }
//    
//    //set data (trouble code long descriptiob
//    [currCellData.childItems addObject:troubleCodeLongDescription];
//    
//    [self updateUI:currCellData];
    
}





#pragma mark - Add/Remove Notification Observers.  Notification Delegation methods
- (void) addObservers
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(processBluetoothReponse:)
                                                 name:Constants.uttCommandNotification
                                               object:nil];
    
    
}


- (void) removeObserver
{

    [[NSNotificationCenter defaultCenter] removeObserver:self name:Constants.uttCommandNotification object:nil];

}




- (void) processBluetoothReponse:(NSNotification *)notification
{
    cmdResponseCounter = cmdResponseCounter + 1;
    if (cmdResponseCounter>=3) {
        //            self.dtcdict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dtc_generic" ofType:@"plist"]];  //[[NSMutableArray alloc] initWithContentsOfFile:path];
        //
        //            for(NSString *key in [self.dtcdict allKeys]) {
        //                //            NSLog(@"%@   %@ ", key, [self.dtcdict objectForKey:key]);
        //
        //                troubleCode = key;
        //                codeShortDescription = [self.dtcdict objectForKey:troubleCode];
        //
        //                tmpCellData = [[TCCellData alloc]initWithTroubleCode:troubleCode troubleCodeDescription:[self getTroubleCodeDescription:troubleCode]];
        //                [listOfItems addObject:tmpCellData];
        //            }
        //
        //            listOfItems.removeAll()
        //
        //            listOfItems[listOfTitle[0]] = Bike.sharedInstance.VINnumber
        //            listOfItems[listOfTitle[1]] = Bike.sharedInstance.ECMversion
        //            listOfItems[listOfTitle[2]] = Bike.sharedInstance.ECMcalib
        //            listOfItems[listOfTitle[3]] = Bike.sharedInstance.deviceStatus
        //            listOfItems[listOfTitle[4]] = Bike.sharedInstance.firmwareVersion
        //            listOfItems[listOfTitle[5]] = Bike.sharedInstance.hardwareVersion
        //            listOfItems[listOfTitle[6]] = Bike.sharedInstance.widebandState
        //            listOfItems[listOfTitle[7]] = Bike.sharedInstance.widebandfversion
        //            listOfItems[listOfTitle[8]] = Bike.sharedInstance.widebandhversion
        //            listOfItems[listOfTitle[9]] = Bike.sharedInstance.iosVersion
        //            listOfItems[listOfTitle[10]] = Bike.sharedInstance.appVersion
        //            listOfItems[listOfTitle[11]] = Bike.sharedInstance.appBuildVersion
        //            listOfItems[listOfTitle[12]] = Bike.sharedInstance.DEVbtversion
        //            listOfItems[listOfTitle[13]] = Bike.sharedInstance.DEVbtmacid
        //            listOfItems[listOfTitle[14]] = Bike.sharedInstance.VINyear
        
        
        //            self.tableView.reloadData;
    }else {
        [self sendReadDtcCommands:cmdResponseCounter];
        
    }
}


#pragma mark - Send Commands



//[self readDtcCommand:0x30];
//[self readDtcCommand:0x31];
//[self readDtcCommand:0x32];

- (void) sendReadDtcCommands: (int)cmdCounter
{
    
    switch (cmdCounter) {
    case 0:
        cmdResponseCounter = 0;
        [[BluetoothUtil sharedInstance] writeWithCmd: @"UTT000" numberOfMilliseconds: 4000];
        break;
        
    case 1:
        [[BluetoothUtil sharedInstance] writeWithCmd: @"UTT100" numberOfMilliseconds: 4000];
        break;
        
    case 2:
        [[BluetoothUtil sharedInstance] writeWithCmd: @"UTT200" numberOfMilliseconds: 4000];
        break;
            
    default:
            break;
    }
    
}


//- (void) sendReadDtcCommands
//{
//
////    [[BluetoothUtil sharedInstance] printMyName];
//    [[BluetoothUtil sharedInstance] writeWithCmd:@"UTT3000"];
//
////    [self readDtcCommand:0x30];
////    [[BluetoothUtil sharedInstance]
//}

//- (void) readDtcCommand: (unsigned char)type
//{
//    uint8_t buf[32];
//
//    sprintf((char*)buf,"UTT%c00",type);
////    [[EAController sharedController] writeData:[NSData dataWithBytes:buf length:6]];
//
//    //printf ("%s\n",buf);
//}


- (void) clearDtcCommand: (unsigned char)type
{
    uint8_t buf[32];
    
    sprintf((char*)buf,"UKT%c00",type);
//    [[EAController sharedController] writeData:[NSData dataWithBytes:buf length:6]];
    
    //printf ("%s\n",buf);
}



#pragma mark - Update Theme

- (void) updateTheme
{
    
    NSString *resourceDirectory = [[NSBundle mainBundle] resourcePath];
    NSString *imageName  = [resourceDirectory stringByAppendingPathComponent:@"background33.png"];
    
//    [self.view setBackgroundColor:[UIColor colorWithPatternImage:  [UIImage imageWithContentsOfFile: imageName]   ]];
//    [self.uinavbarMain setTintColor: [[EAController sharedController] getNavBarTintColor]];
//    
//    [self.uinavbarMain setAlpha:  [[EAController sharedController] getNavBarAlpha]];
//    [self.uinavbarMain setHidden: [[EAController sharedController] getNavBarHidden]];
//    
    [self.uinavbtnBack setTintColor: [UIColor blackColor] ];

    
    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
//    {
//        [self.uinavbtnBack setTintColor: [UIColor whiteColor] ];
//        [self.uinavbtnRefresh setTintColor: [UIColor whiteColor] ];
//        
//    }
//    else
//    {
//        [self.uinavbtnBack setTintColor: [UIColor clearColor] ];
//        [self.uinavbtnRefresh setTintColor: [UIColor clearColor] ];
//    }
//    
    
    
//    BOOL navflag = [[EAController sharedController] getNavBarColorOverwritesGradient];
////    navflag = true;
//    if ( navflag==TRUE )
//    {
//        [self.uinavbarMain setTintColor: [[EAController sharedController] getNavBarTintColor]];
//        [self.uinavbarMain setBackgroundImage:[UIImage imageWithContentsOfFile: imageName] forBarMetrics:UIBarMetricsDefault];
////        [self.uinavbarMain setBackgroundImage:[UIImage imageWithContentsOfFile: imageName] forBarMetrics:UIBarMetricsCompact];
//
//        
//        [self.uinavbarMain setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//        [self.uinavbarMain setBackgroundImage:nil forBarMetrics:UIBarMetricsCompact];
////        [self.uinavbarMain setBackgroundImage:nil forBarMetrics:UIBarMetricsLandscapePhone];
//        
//    }
//    else
//    {
//        UIImage *gradientImage44 = [[UIImage imageWithData:[[EAController sharedController] getNavBarBackgroundImageForBarMetricsDefaultName]] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//        UIImage *gradientImage32 = [[UIImage imageWithData:[[EAController sharedController] getNavBarBackgroundImageForBarMetricsLandscapePhone]] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//        
//        [self.uinavbarMain setBackgroundImage:gradientImage44 forBarMetrics:UIBarMetricsDefault];
//        [self.uinavbarMain setBackgroundImage:gradientImage32 forBarMetrics:UIBarMetricsLandscapePhone];
//    }
//    
    
//    [self.uinavbarMain setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:
//      [[EAController sharedController] getNavBarTitleTextColor],          UITextAttributeTextColor,
//      [[EAController sharedController] getNavBarTitleTextColorShadow],    UITextAttributeTextShadowColor,
//      nil]];
//    
//    
    
//    [self.tableView setSeparatorColor:[[EAController sharedController] getCellSeparatorColor] ];
    
    


    [self setStatusBarColor];
    
}





- (void) setStatusBarColor
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
