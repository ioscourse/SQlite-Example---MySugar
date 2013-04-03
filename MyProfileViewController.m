//
//  MyProfileViewController.m
//  MySugar
//
//  Created by Charles Konkol on 3/12/13.
//  Copyright (c) 2013 RVC Student. All rights reserved.
//

#import "MyProfileViewController.h"
#import "FMDatabase.h"
//#import "FMDatabaseQueue.h"
#import "FMResultSet.h"

@implementation MyProfileViewController
@synthesize txtFullName=txtFullName;
@synthesize txtEmail=txtEmail;
@synthesize ScrollView=ScrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSInteger id;
    NSString *fullname;
    NSString *email;
	// Do any additional setup after loading the view.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"MySugar.sqlite"];
    //NSLog(@"Path: %@",path);
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
	// Do any additional setup after loading the view, typically from a nib.
    // Do any additional setup after loading the view, typically from a nib.
    FMResultSet *results = [database executeQuery:@"select * from personal"];
     id = [results intForColumn:@"id"] ;
    fullname = [results stringForColumn:@"fullname"] ;
    email = [results stringForColumn:@"email"] ;
    if (id != 1)
    {
        // Do any additional setup after loading the view, typically from a nib.
        //Date to write
      
        [database executeUpdate:@"insert into personal(fullname, email) values(?,?)",
         @"Enter Full Name",@"Enter Email"];
       
    }
    

     // NSLog(@"Path: %int",(int)id);
   
    [results close]; //VERY IMPORTANT!
    [database close];
 
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSave:(id)sender {
    [txtFullName resignFirstResponder];
    [txtEmail resignFirstResponder];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"MySugar.sqlite"];
    NSLog(@"Path: %@",path);
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
	// Do any additional setup after loading the view, typically from a nib.
    // Do any additional setup after loading the view, typically from a nib.
    [database beginTransaction];
    NSString *query = @"";
    query =[NSString stringWithFormat:@"UPDATE Personal SET fullname= '%@', email = '%@' WHERE id = 1",txtFullName.text,txtEmail.text];
    [database executeUpdate: query];
    [database commit];
    [database close];
   
}
-(void)dismissKeyboard {
    [txtFullName resignFirstResponder];
    [txtEmail resignFirstResponder];
}
-(IBAction) doneEditing:(id) sender {
    [sender resignFirstResponder];
}
@end
