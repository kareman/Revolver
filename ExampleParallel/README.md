# Revolver Example: Parallel Evaluation
This example shows how Revolver evaluation can be parallelized.

## Parallelization FAQ

 - **What is parallelization?** Parallelization is when you do multiple things simultaneously. [Read more about it on the Wikipedia.](https://en.wikipedia.org/wiki/Parallel_computing)
 - **Why parallelize?** Because it makes the overall algorithm *run a lot faster*. In fact, you can accelerate up to *N times* with respect to the regular sequential evaluation (where *N* is the number of cores inside your CPU).
 - **What is parallelized?** Fitness evaluation, as it's often the most time-consuming part of genetic algorithms.
 - **How it's done?** You instantiate a non-empty set of `SequentialEvaluator<T>` subclasses and wrap them inside a `ParallelEvaluator<T>` instance. Revolver does the rest of the work.
 - **Are there any requirements?** Yeah, there are two:
   1. CPU of your machine must have more than one core, duh.
   2. Your subclasses of `SequentialEvaluator<T>` must not interfere with each other's work.
 - **What is thread-safe?** Nothing, unless declared otherwise in the documentation.
 
## The Setup
Since this is a demonstration of parallelization, not genetic algorithms, the problem this application solves is downright ridiculous. Chromosomes contain *no information at all* and evaluators rate them with *random fitness values*. To simulate a real-world scenario, evaluators take non-deterministic amount of time between 0 and 3 seconds to complete evaluation of a single chromosome.

## Credits
The example code was created by [Petr Mánek](https://github.com/petrmanek), Charles University, 2016.

This example is distributed under the [MIT License](https://en.wikipedia.org/wiki/MIT_License).

## Dependencies

 - Revolver
 - Xcode 7.3
 - Mac OS 10.11 El Capitan *(perhaps this example can be ported to Linux?)*

## Usage

 1. Build and run the project in Xcode. *(don't use xcodeproj in this directory, use xcworkspace in the parent directory)*
 2. Hit the *Run sequential algorithm* button.
 3. Observe the output generated in the log. Note the time required to complete.
 4. Hit the *Run parallel algorithm* button.
 5. Observe the output generated in the log. Note that the time to complete was significantly smaller in comparison to the sequential case.
 6. Change parameters of the algorithm in `ViewController.swift` and observe how the output changes.

## Example Ouptut
When running this example, you should see similar output (provided that you don't change the seed).

### Sequential Evaluation

```
Initialized.


---
Run started.
Evaluating individual... (waiting 1.68518240626091 s)
Evaluating individual... (waiting 0.465932306709218 s)
Evaluating individual... (waiting 0.368351517796598 s)
Evaluating individual... (waiting 2.4606887857571 s)
Evaluating individual... (waiting 2.50688587490164 s)
Evaluating individual... (waiting 0.795980634353119 s)
Evaluating individual... (waiting 0.926699810411478 s)
Evaluating individual... (waiting 1.36344773912883 s)
Evaluating individual... (waiting 2.36661367126894 s)
Evaluating individual... (waiting 2.75776937551745 s)
Evaluating individual... (waiting 0.386792691048885 s)
Evaluating individual... (waiting 1.81524253143353 s)
Evaluating individual... (waiting 0.0699917518231067 s)
Evaluating individual... (waiting 2.01886624051697 s)
Evaluating individual... (waiting 0.233318791546235 s)
Evaluating individual... (waiting 1.68016508284029 s)
Evaluating individual... (waiting 1.01951376698434 s)
Evaluating individual... (waiting 2.06139443094409 s)
Evaluating individual... (waiting 0.455794199941632 s)
Evaluating individual... (waiting 2.18661358025545 s)
Evaluating individual... (waiting 0.521228951989028 s)
Evaluating individual... (waiting 2.56175388501998 s)
Evaluating individual... (waiting 1.77460744832051 s)
Evaluating individual... (waiting 1.11303235872486 s)
Evaluating individual... (waiting 0.488887256358025 s)
Evaluating individual... (waiting 2.98128173988808 s)
Evaluating individual... (waiting 2.17672106744179 s)
Evaluating individual... (waiting 1.70832847308096 s)
Evaluating individual... (waiting 1.25583377579596 s)
Evaluating individual... (waiting 1.79302387470217 s)
Generation 1:		best: 0.991231545571059,		mean: 0.559620427928466

Evaluating individual... (waiting 1.53893759160743 s)
Evaluating individual... (waiting 1.7830167847646 s)
Evaluating individual... (waiting 2.77895675501296 s)
Evaluating individual... (waiting 0.852407243999747 s)
Evaluating individual... (waiting 1.05517661852184 s)
Evaluating individual... (waiting 0.144461400607708 s)
Evaluating individual... (waiting 1.19470447911758 s)
Evaluating individual... (waiting 2.67741857275307 s)
Evaluating individual... (waiting 0.139417521222359 s)
Evaluating individual... (waiting 0.378032336565208 s)
Evaluating individual... (waiting 2.69641476629684 s)
Evaluating individual... (waiting 1.94528219917446 s)
Evaluating individual... (waiting 1.69356248497347 s)
Evaluating individual... (waiting 2.47003146388336 s)
Evaluating individual... (waiting 1.8901317517483 s)
Evaluating individual... (waiting 1.68315068322307 s)
Evaluating individual... (waiting 1.58881674045436 s)
Evaluating individual... (waiting 1.2029583137955 s)
Evaluating individual... (waiting 1.98535166866736 s)
Evaluating individual... (waiting 2.41475078403362 s)
Evaluating individual... (waiting 0.783851660039241 s)
Evaluating individual... (waiting 2.53245697927951 s)
Evaluating individual... (waiting 2.83315471649011 s)
Evaluating individual... (waiting 0.247185565588806 s)
Evaluating individual... (waiting 0.698522412613622 s)
Evaluating individual... (waiting 1.5914397969822 s)
Evaluating individual... (waiting 2.24720094707962 s)
Evaluating individual... (waiting 2.49272411654068 s)
Evaluating individual... (waiting 1.77524825389852 s)
Generation 2:		best: 0.991231545571059,		mean: 0.481653638707549

Run finished.


---
BEST FITNESS:		0.991231545571059
TIME: 91.4587079882622 seconds
```

### Parallel Evaluation

```
Thread 0: Initialized.
Thread 1: Initialized.
Thread 2: Initialized.
Thread 3: Initialized.
Thread 4: Initialized.
Thread 5: Initialized.
Thread 6: Initialized.
Thread 7: Initialized.


---
Run started.
Thread 0: Evaluating individual... (waiting 1.0080722121075 s)
Thread 1: Evaluating individual... (waiting 1.51013010589176 s)
Thread 2: Evaluating individual... (waiting 2.75281878461894 s)
Thread 3: Evaluating individual... (waiting 1.12757931722505 s)
Thread 4: Evaluating individual... (waiting 1.3443003709764 s)
Thread 5: Evaluating individual... (waiting 1.05560794217875 s)
Thread 6: Evaluating individual... (waiting 2.22473868569935 s)
Thread 7: Evaluating individual... (waiting 2.39362956289985 s)
Thread 0: Evaluating individual... (waiting 0.407326080232702 s)
Thread 5: Evaluating individual... (waiting 0.706069034688656 s)
Thread 3: Evaluating individual... (waiting 0.828874409624579 s)
Thread 4: Evaluating individual... (waiting 1.56003623957747 s)
Thread 0: Evaluating individual... (waiting 0.485954213302106 s)
Thread 1: Evaluating individual... (waiting 2.48986475041366 s)
Thread 5: Evaluating individual... (waiting 1.38968434077447 s)
Thread 0: Evaluating individual... (waiting 1.81872355887171 s)
Thread 3: Evaluating individual... (waiting 1.67186126687374 s)
Thread 6: Evaluating individual... (waiting 1.47311745781291 s)
Thread 7: Evaluating individual... (waiting 2.27418252180195 s)
Thread 2: Evaluating individual... (waiting 2.31893454709066 s)
Thread 4: Evaluating individual... (waiting 0.524006320751274 s)
Thread 5: Evaluating individual... (waiting 0.858476254590432 s)
Thread 4: Evaluating individual... (waiting 0.183187529021685 s)
Thread 4: Evaluating individual... (waiting 1.23576899367286 s)
Thread 3: Evaluating individual... (waiting 1.50881585839875 s)
Thread 6: Evaluating individual... (waiting 2.46254240243289 s)
Thread 0: Evaluating individual... (waiting 1.14690549162843 s)
Thread 1: Evaluating individual... (waiting 0.625467750622301 s)
Thread 5: Evaluating individual... (waiting 1.07896157076558 s)
Thread 1: Evaluating individual... (waiting 1.20351577601477 s)
Generation 1:		best: 0.976083170151357,		mean: 0.507861942155565

Thread 0: Evaluating individual... (waiting 1.4185457011728 s)
Thread 1: Evaluating individual... (waiting 0.535211872666891 s)
Thread 2: Evaluating individual... (waiting 0.646836729638008 s)
Thread 3: Evaluating individual... (waiting 0.71407594059456 s)
Thread 4: Evaluating individual... (waiting 2.24291395424933 s)
Thread 5: Evaluating individual... (waiting 1.25582035776596 s)
Thread 6: Evaluating individual... (waiting 1.47803602355487 s)
Thread 7: Evaluating individual... (waiting 1.19667856329975 s)
Thread 1: Evaluating individual... (waiting 1.10883848674335 s)
Thread 2: Evaluating individual... (waiting 1.7910775087753 s)
Thread 3: Evaluating individual... (waiting 2.60682164821933 s)
Thread 7: Evaluating individual... (waiting 0.422558677713982 s)
Thread 5: Evaluating individual... (waiting 0.931582200557827 s)
Thread 0: Evaluating individual... (waiting 1.64512442905575 s)
Thread 6: Evaluating individual... (waiting 2.42363978815815 s)
Thread 7: Evaluating individual... (waiting 1.91652916020633 s)
Thread 1: Evaluating individual... (waiting 1.30101529399422 s)
Thread 5: Evaluating individual... (waiting 1.5640538261654 s)
Thread 4: Evaluating individual... (waiting 0.736770695014105 s)
Thread 2: Evaluating individual... (waiting 0.648656760726277 s)
Thread 1: Evaluating individual... (waiting 2.40227341940679 s)
Thread 4: Evaluating individual... (waiting 0.994200267129159 s)
Thread 0: Evaluating individual... (waiting 0.0270281878828602 s)
Thread 0: Evaluating individual... (waiting 0.225587353395668 s)
Thread 2: Evaluating individual... (waiting 2.67281359566208 s)
Thread 0: Evaluating individual... (waiting 0.811461906836243 s)
Thread 3: Evaluating individual... (waiting 2.66227899623622 s)
Thread 7: Evaluating individual... (waiting 0.419218185455356 s)
Thread 5: Evaluating individual... (waiting 0.983614818887695 s)
Generation 2:		best: 0.99493461008997,		mean: 0.559528802450016

Run finished.


---
BEST FITNESS:		0.99493461008997
TIME: 12.174181997776 seconds
```
