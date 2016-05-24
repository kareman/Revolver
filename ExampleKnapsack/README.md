# Revolver Example: Knapsack
This example shows how Revolver can be applied to solve the Knapsack Problem.

## The Knapsack Problem
> The knapsack problem or rucksack problem is a problem in combinatorial optimization: Given a set of items, each with a size and a value, determine the number of each item to include in a collection so that the total size is less than or equal to a given limit and the total value is as large as possible. It derives its name from the problem faced by someone who is constrained by a fixed-size knapsack and must fill it with the most valuable items.

[Read more](https://en.wikipedia.org/wiki/Knapsack_problem) about the problem on Wikipedia.

## Credits
The example code was created by [Petr Mánek](https://github.com/petrmanek), Charles University, 2016.
[The sample problem instance](https://people.sc.fsu.edu/~jburkardt/datasets/knapsack_01/knapsack_01.html) was provided by Florida State University.

This example is distributed under the [MIT License](https://en.wikipedia.org/wiki/MIT_License).

## Dependencies

 - Revolver
 - Xcode 7.3
 - Mac OS 10.11 El Capitan *(perhaps this example can be ported to Linux?)*

## Usage

 1. Build and run the project in Xcode. *(don't use xcodeproj in this directory, use xcworkspace in the parent directory)*
 2. Hit the *Run algorithm* button.
 3. Observe the output generated in the log.
 4. Play around with `ProblemInstance.swift` to change the weights and values of things and observe how the output changes.
 5. Change parameters of the algorithm in `ViewController.swift` and observe how the output changes.

## Example Ouptut
When running this example, you should see similar output (provided that you don't change the seed or the problem instance).
```
---
Run started.
Generation 1:		best: 0.390279823269514,		mean: 0.0258541973490427
Generation 2:		best: 0.390279823269514,		mean: 0.0430117820324006
Generation 3:		best: 0.407952871870398,		mean: 0.0716715758468336
Generation 4:		best: 0.407952871870398,		mean: 0.0854565537555229
Generation 5:		best: 0.407952871870398,		mean: 0.102731958762887
Generation 6:		best: 0.407952871870398,		mean: 0.112481590574374
Generation 7:		best: 0.407952871870398,		mean: 0.11980854197349
Generation 8:		best: 0.418262150220913,		mean: 0.126723122238586
Generation 9:		best: 0.418262150220913,		mean: 0.130022091310751
Generation 10:		best: 0.418262150220913,		mean: 0.149528718703976
Generation 11:		best: 0.418262150220913,		mean: 0.150854197349042
Generation 12:		best: 0.418262150220913,		mean: 0.157577319587629
Generation 13:		best: 0.418262150220913,		mean: 0.166870397643593
Generation 14:		best: 0.418262150220913,		mean: 0.192908799155914
Generation 15:		best: 0.418262150220913,		mean: 0.191472754050073
Generation 16:		best: 0.418262150220913,		mean: 0.198718703976436
Generation 17:		best: 0.418262150220913,		mean: 0.18641384388807
Generation 18:		best: 0.418262150220913,		mean: 0.178505154639175
Generation 19:		best: 0.418262150220913,		mean: 0.169823269513991
Generation 20:		best: 0.418262150220913,		mean: 0.170353460972017
Generation 21:		best: 0.418262150220913,		mean: 0.183571428571428
Generation 22:		best: 0.418262150220913,		mean: 0.197268444229515
Generation 23:		best: 0.418262150220913,		mean: 0.206855670103093
Generation 24:		best: 0.455081001472754,		mean: 0.21561119293078
Generation 25:		best: 0.455081001472754,		mean: 0.219189985272459
Generation 26:		best: 0.455081001472754,		mean: 0.218453608247423
Generation 27:		best: 0.455081001472754,		mean: 0.215513009327442
Generation 28:		best: 0.455081001472754,		mean: 0.209977908689249
Generation 29:		best: 0.455081001472754,		mean: 0.208939617083947
Generation 30:		best: 0.455081001472754,		mean: 0.212076583210604
Generation 31:		best: 0.455081001472754,		mean: 0.224896907216495
Generation 32:		best: 0.455081001472754,		mean: 0.209256259204713
Generation 33:		best: 0.455081001472754,		mean: 0.227466863033873
Generation 34:		best: 0.455081001472754,		mean: 0.240434462444772
Generation 35:		best: 0.455081001472754,		mean: 0.222253313696613
Generation 36:		best: 0.455081001472754,		mean: 0.230154639175258
Generation 37:		best: 0.455081001472754,		mean: 0.235876288659794
Generation 38:		best: 0.455081001472754,		mean: 0.225390279823269
Generation 39:		best: 0.455081001472754,		mean: 0.219484536082474
Generation 40:		best: 0.455081001472754,		mean: 0.225228276877761
Generation 41:		best: 0.455081001472754,		mean: 0.230648011782032
Generation 42:		best: 0.455081001472754,		mean: 0.231104565537555
Generation 43:		best: 0.455081001472754,		mean: 0.223932253313696
Generation 44:		best: 0.455081001472754,		mean: 0.227562592047128
Generation 45:		best: 0.455081001472754,		mean: 0.237746686303387
Generation 46:		best: 0.455081001472754,		mean: 0.253674521354934
Generation 47:		best: 0.455081001472754,		mean: 0.25159793814433
Generation 48:		best: 0.455081001472754,		mean: 0.239721861971439
Generation 49:		best: 0.455081001472754,		mean: 0.26304413133156
Generation 50:		best: 0.455081001472754,		mean: 0.264705449189985
Generation 51:		best: 0.455081001472754,		mean: 0.269977908689249
Generation 52:		best: 0.455081001472754,		mean: 0.249072164948454
Generation 53:		best: 0.455081001472754,		mean: 0.242518409425626
Generation 54:		best: 0.455081001472754,		mean: 0.240861561119293
Generation 55:		best: 0.455081001472754,		mean: 0.236782032400589
Generation 56:		best: 0.455081001472754,		mean: 0.245913107511046
Generation 57:		best: 0.455081001472754,		mean: 0.246023564064801
Generation 58:		best: 0.455081001472754,		mean: 0.245279823269514
Generation 59:		best: 0.455081001472754,		mean: 0.251759941089838
Generation 60:		best: 0.455081001472754,		mean: 0.239905040335876
Generation 61:		best: 0.455081001472754,		mean: 0.254455081001473
Generation 62:		best: 0.455081001472754,		mean: 0.257739322533137
Generation 63:		best: 0.455081001472754,		mean: 0.285765832106038
Generation 64:		best: 0.455081001472754,		mean: 0.3004491533496
Generation 65:		best: 0.455081001472754,		mean: 0.304145802650957
Generation 66:		best: 0.455081001472754,		mean: 0.29938880706922
Generation 67:		best: 0.455081001472754,		mean: 0.284050073637703
Generation 68:		best: 0.455081001472754,		mean: 0.291244477172312
Generation 69:		best: 0.455081001472754,		mean: 0.29859351988218
Generation 70:		best: 0.455081001472754,		mean: 0.295810014727541
Generation 71:		best: 0.455081001472754,		mean: 0.295412371134021
Generation 72:		best: 0.455081001472754,		mean: 0.281435239121037
Generation 73:		best: 0.455081001472754,		mean: 0.263762886597938
Generation 74:		best: 0.455081001472754,		mean: 0.263901406077126
Generation 75:		best: 0.455081001472754,		mean: 0.245044182621502
Generation 76:		best: 0.455081001472754,		mean: 0.253173784977909
Generation 77:		best: 0.455081001472754,		mean: 0.257209131075111
Generation 78:		best: 0.455081001472754,		mean: 0.264113892979872
Generation 79:		best: 0.455081001472754,		mean: 0.256833578792342
Generation 80:		best: 0.455081001472754,		mean: 0.261811487481591
Generation 81:		best: 0.455081001472754,		mean: 0.25379234167894
Generation 82:		best: 0.455081001472754,		mean: 0.252746686303387
Generation 83:		best: 0.455081001472754,		mean: 0.275022091310751
Generation 84:		best: 0.455081001472754,		mean: 0.28699558173785
Generation 85:		best: 0.455081001472754,		mean: 0.284779086892489
Generation 86:		best: 0.455081001472754,		mean: 0.290352361901831
Generation 87:		best: 0.455081001472754,		mean: 0.282444771723122
Generation 88:		best: 0.455081001472754,		mean: 0.287083946980854
Generation 89:		best: 0.455081001472754,		mean: 0.291715758468336
Generation 90:		best: 0.455081001472754,		mean: 0.28820324005891
Generation 91:		best: 0.455081001472754,		mean: 0.298888070692195
Generation 92:		best: 0.455081001472754,		mean: 0.284483327105269
Generation 93:		best: 0.455081001472754,		mean: 0.285274657639637
Generation 94:		best: 0.455081001472754,		mean: 0.285162002945508
Generation 95:		best: 0.455081001472754,		mean: 0.287665684830633
Generation 96:		best: 0.455081001472754,		mean: 0.280773195876289
Generation 97:		best: 0.455081001472754,		mean: 0.284646539027982
Generation 98:		best: 0.455081001472754,		mean: 0.306509572901326
Generation 99:		best: 0.455081001472754,		mean: 0.304455081001473
Generation 100:		best: 0.455081001472754,		mean: 0.303932253313697
Run finished.


---
BEST FITNESS:		0.455081001472754		CHROMOSOME: [true, true, true, true, false, true, false, false, false, false]
OPTIMAL FITNESS:	0.455081001472754		CHROMOSOME: [true, true, true, true, false, true, false, false, false, false]

YAY, SOLUTIONS MATCH!
TIME: 0.427188992500305 seconds
```
