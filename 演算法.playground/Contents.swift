//: Playground - noun: a place where people can play

import UIKit

func determineArray(var numbers:[Int], target:Int) ->(index1:Int , index2:Int) {
    var count = 0;
    var finResult = 0;
    while count < numbers.count
    {
        let compareTarget = numbers[count];
        var tmp = target - compareTarget;
        let index = numbers.indexOf(tmp);
        if
            index != nil
        {
            if index == count
            {
                numbers.removeAtIndex(count);
                tmp = numbers.indexOf(tmp)!;
                finResult = tmp + 2;
            }
            else
            {
                finResult = index! + 1
            };
            break
        }
        else
        {
            count++
        }
    };
    count = count + 1;
    return(count,finResult)

};
var array = [2,7,11,15];
var result = determineArray(array, target: 18);
let index1 = result.index1;
let index2 = result.index2;

