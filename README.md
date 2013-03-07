HOUCrashSimulator
=================

A easily extendable collection of crashing- or close-to-crash blocks for iOS (yet only tested with SDK >= 6), wrapped in a grouped UITableView which can be included quickly in any Project.

Initial goal was to test, which Crashes a CrashReporter I was using would actually catch, and how they would look like in a crash report. 

How to use it:

1. Include HOUCrashSimulator/* in your project
2. present or add-as-a-child-view-controller the HOUCrashSimulatorViewController OR use methods of HOUCrashSimulator directly
3. watch your App crash or block or die
4. See what your IDE or CrashReporter made of it
