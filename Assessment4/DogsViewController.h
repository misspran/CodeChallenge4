//
//  DogsViewController.h
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import <CoreData/CoreData.h>

@interface DogsViewController : UIViewController
@property (weak, nonatomic) Person *detailPerson;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
