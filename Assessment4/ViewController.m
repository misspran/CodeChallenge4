//
//  ViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import "Dog.h"
#import "Person.h"
#import <CoreData/CoreData.h>
#import "DogsViewController.h"
#import "AddDogViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property UIAlertView *addAlert;
@property UIAlertView *colorAlert;
@property NSArray *dogOwnersArray;
@property NSArray *personList;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dog Owners";
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Person"];

    [self loadData];
    NSArray *dogOwnersArray = [self.managedObjectContext executeFetchRequest:request error:nil];
}

#pragma mark - UITableView Delegate Methods
- (void)loadData{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/25/owners.json"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         NSArray *ownersArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
         for (NSString *name in ownersArray) {
             Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
             person.name = name;

         }
         [self.managedObjectContext save:nil];

     }];
    [self fetchData];

}
-(void)fetchData{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Person"];
     self.personList = [self.managedObjectContext executeFetchRequest:request error:nil];
    NSLog(@"%@",@(self.personList.count));
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //TODO: UPDATE THIS ACCORDINGLY
    return self.personList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"myCell"];
    //TODO: UPDATE THIS ACCORDINGLY
    Person *ppl = [self.personList objectAtIndex:indexPath.row];
    cell.textLabel.text = ppl.name;
    return cell;

 //   NSManagedObject *character = [Person.perror objectAtIndex:indexPath.row];

}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    Person *ownername = [self.personList objectAtIndex:self.myTableView.indexPathForSelectedRow.row];
    DogsViewController *viewController = segue.destinationViewController;
    viewController.detailPerson = ownername;

}
#pragma mark - UIAlertView Methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //TODO: SAVE USER'S DEFAULT COLOR PREFERENCE USING THE CONDITIONAL BELOW

    if (buttonIndex == 0)
    {
        self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
    }
    else if (buttonIndex == 1)
    {
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    }
    else if (buttonIndex == 2)
    {
        self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    }
    else if (buttonIndex == 3)
    {
        self.navigationController.navigationBar.tintColor = [UIColor greenColor];
    }

}

//METHOD FOR PRESENTING USER'S COLOR PREFERENCE
- (IBAction)onColorButtonTapped:(UIBarButtonItem *)sender
{
    self.colorAlert = [[UIAlertView alloc] initWithTitle:@"Choose a default color!"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Purple", @"Blue", @"Orange", @"Green", nil];
    self.colorAlert.tag = 1;
    [self.colorAlert show];
}

@end
