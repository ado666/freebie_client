//
//  testObj.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 05/08/15.
//  Copyright (c) 2015 Boris Kuznetsov. All rights reserved.
//

#import "testObj.h"

@implementation testObj
- (id)init
{
    self = [super init]; //вызываем конструктор базового класса для
    //инициализации его инвариантов
    if (self) //если в конструкторе базового класса все прошло удачно
        //и он вернул корректный объект, а не освободив память вернул nil
    {
        //то тут можно смело инициализировать свои инварианты
    }
    return self; //и возвращать самого себя
}

- (void)method1:(int)iden :(int)ident {
    NSLog(@"%i %i", iden, ident);
}

@end
