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
Generation 1:		best: 0.391752577319588,		mean: 0.0258983799705449
Generation 2:		best: 0.391752577319588,		mean: 0.0482768777614139
Generation 3:		best: 0.407952871870398,		mean: 0.0583972625825219
Generation 4:		best: 0.407952871870398,		mean: 0.0639175257731959
Generation 5:		best: 0.407952871870398,		mean: 0.0756332842415317
Generation 6:		best: 0.407952871870398,		mean: 0.0781811487481591
Generation 7:		best: 0.407952871870398,		mean: 0.0898085419734904
Generation 8:		best: 0.407952871870398,		mean: 0.096073388579928
Generation 9:		best: 0.407952871870398,		mean: 0.116789396170839
Generation 10:		best: 0.407952871870398,		mean: 0.137238586156112
Generation 11:		best: 0.407952871870398,		mean: 0.145036818851252
Generation 12:		best: 0.407952871870398,		mean: 0.165022091310751
Generation 13:		best: 0.407952871870398,		mean: 0.159712812960235
Generation 14:		best: 0.407952871870398,		mean: 0.172731958762886
Generation 15:		best: 0.407952871870398,		mean: 0.173416789396171
Generation 16:		best: 0.455081001472754,		mean: 0.173144329896907
Generation 17:		best: 0.455081001472754,		mean: 0.166568483063328
Generation 18:		best: 0.455081001472754,		mean: 0.168343151693667
Generation 19:		best: 0.455081001472754,		mean: 0.165324005891016
Generation 20:		best: 0.455081001472754,		mean: 0.155736377025037
Generation 21:		best: 0.455081001472754,		mean: 0.156016200294551
Generation 22:		best: 0.455081001472754,		mean: 0.141553755522828
Generation 23:		best: 0.455081001472754,		mean: 0.141494845360825
Generation 24:		best: 0.455081001472754,		mean: 0.152430044182621
Generation 25:		best: 0.455081001472754,		mean: 0.153652430044182
Generation 26:		best: 0.455081001472754,		mean: 0.175817378497791
Generation 27:		best: 0.455081001472754,		mean: 0.158711340206185
Generation 28:		best: 0.455081001472754,		mean: 0.163424153166421
Generation 29:		best: 0.455081001472754,		mean: 0.174359351988218
Generation 30:		best: 0.455081001472754,		mean: 0.163123997098454
Generation 31:		best: 0.455081001472754,		mean: 0.170368188512518
Generation 32:		best: 0.455081001472754,		mean: 0.178895434462445
Generation 33:		best: 0.455081001472754,		mean: 0.186021292653082
Generation 34:		best: 0.455081001472754,		mean: 0.184904270986745
Generation 35:		best: 0.455081001472754,		mean: 0.1780117820324
Generation 36:		best: 0.455081001472754,		mean: 0.21321060382916
Generation 37:		best: 0.455081001472754,		mean: 0.224307805596465
Generation 38:		best: 0.455081001472754,		mean: 0.202555228276878
Generation 39:		best: 0.455081001472754,		mean: 0.195257731958763
Generation 40:		best: 0.455081001472754,		mean: 0.199970544918998
Generation 41:		best: 0.455081001472754,		mean: 0.20460972017673
Generation 42:		best: 0.455081001472754,		mean: 0.216708394698085
Generation 43:		best: 0.455081001472754,		mean: 0.227761413843888
Generation 44:		best: 0.455081001472754,		mean: 0.236288659793814
Generation 45:		best: 0.455081001472754,		mean: 0.246362297496318
Generation 46:		best: 0.455081001472754,		mean: 0.244064801178203
Generation 47:		best: 0.455081001472754,		mean: 0.256826215022092
Generation 48:		best: 0.455081001472754,		mean: 0.229219440353461
Generation 49:		best: 0.455081001472754,		mean: 0.227368313073806
Generation 50:		best: 0.455081001472754,		mean: 0.234948453608247
Generation 51:		best: 0.455081001472754,		mean: 0.250751104565538
Generation 52:		best: 0.455081001472754,		mean: 0.252761413843888
Generation 53:		best: 0.455081001472754,		mean: 0.266863033873343
Generation 54:		best: 0.455081001472754,		mean: 0.259543446244477
Generation 55:		best: 0.455081001472754,		mean: 0.262606774668631
Generation 56:		best: 0.455081001472754,		mean: 0.24300441826215
Generation 57:		best: 0.455081001472754,		mean: 0.255427098674522
Generation 58:		best: 0.455081001472754,		mean: 0.243832384469406
Generation 59:		best: 0.455081001472754,		mean: 0.232584683357879
Generation 60:		best: 0.455081001472754,		mean: 0.234948453608247
Generation 61:		best: 0.455081001472754,		mean: 0.222474226804124
Generation 62:		best: 0.455081001472754,		mean: 0.227525773195876
Generation 63:		best: 0.455081001472754,		mean: 0.230846833578792
Generation 64:		best: 0.455081001472754,		mean: 0.224635291876406
Generation 65:		best: 0.455081001472754,		mean: 0.218078055964654
Generation 66:		best: 0.455081001472754,		mean: 0.224712812960236
Generation 67:		best: 0.455081001472754,		mean: 0.217908689248895
Generation 68:		best: 0.455081001472754,		mean: 0.226450662739322
Generation 69:		best: 0.455081001472754,		mean: 0.224955817378498
Generation 70:		best: 0.455081001472754,		mean: 0.221855670103093
Generation 71:		best: 0.455081001472754,		mean: 0.235751104565538
Generation 72:		best: 0.455081001472754,		mean: 0.253711340206186
Generation 73:		best: 0.455081001472754,		mean: 0.26639911634757
Generation 74:		best: 0.455081001472754,		mean: 0.265810014727541
Generation 75:		best: 0.455081001472754,		mean: 0.237584683357879
Generation 76:		best: 0.455081001472754,		mean: 0.237098674521355
Generation 77:		best: 0.455081001472754,		mean: 0.235927835051546
Generation 78:		best: 0.455081001472754,		mean: 0.225110456553755
Generation 79:		best: 0.455081001472754,		mean: 0.228667157584683
Generation 80:		best: 0.455081001472754,		mean: 0.243033873343152
Generation 81:		best: 0.455081001472754,		mean: 0.232636229749632
Generation 82:		best: 0.455081001472754,		mean: 0.217371134020619
Generation 83:		best: 0.455081001472754,		mean: 0.220905780376468
Generation 84:		best: 0.455081001472754,		mean: 0.231053019145803
Generation 85:		best: 0.455081001472754,		mean: 0.245
Generation 86:		best: 0.455081001472754,		mean: 0.246384388807069
Generation 87:		best: 0.455081001472754,		mean: 0.220655375552283
Generation 88:		best: 0.455081001472754,		mean: 0.239020618556701
Generation 89:		best: 0.455081001472754,		mean: 0.243436719202222
Generation 90:		best: 0.455081001472754,		mean: 0.231686303387334
Generation 91:		best: 0.455081001472754,		mean: 0.242017673048601
Generation 92:		best: 0.455081001472754,		mean: 0.243217967599411
Generation 93:		best: 0.455081001472754,		mean: 0.255147275405007
Generation 94:		best: 0.455081001472754,		mean: 0.250640648011782
Generation 95:		best: 0.455081001472754,		mean: 0.247555228276878
Generation 96:		best: 0.455081001472754,		mean: 0.24480854197349
Generation 97:		best: 0.455081001472754,		mean: 0.241163475699558
Generation 98:		best: 0.455081001472754,		mean: 0.235029455081001
Generation 99:		best: 0.455081001472754,		mean: 0.24120765832106
Generation 100:		best: 0.455081001472754,		mean: 0.256251840942562
Run finished.


---
BEST FITNESS:		0.455081001472754		CHROMOSOME: [true, true, true, true, false, true, false, false, false, false]
OPTIMAL FITNESS:	0.455081001472754		CHROMOSOME: [true, true, true, true, false, true, false, false, false, false]

YAY, SOLUTIONS MATCH!
TIME: 0.415289044380188 seconds
```
