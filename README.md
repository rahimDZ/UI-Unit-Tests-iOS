# UI UnitTests iOS
A new way to test your UI very quicly with unit tests by mocking the Business logic.
This new way use a storyboard generator that mock the storyboard and replacing a mocked viewcontroller that inherit from the viewcontroller that you want to test.

- [Code Coverage](#code-coverage)
- [Why do we need a ViewControllerMock?](#why-do-we-need-a-viewcontrollermock)
- [Python Script Generator](#python-script-generator)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Credits](#credits)
- [License](#license)

## Code Coverage

The fact that those UI Tests are not using the Apple UI Tests but the simple Unit test, it allows to gather code coverage (by using Slather) if you want to have Continuous integration and continuous deployment with Jenkins for example! That Apple UI Tests cannot retrieve it with slather but only from xCode.

![alt text](https://github.com/rahimDZ/UI-Unit-Tests-iOS/blob/master/screens/xcode_code_coverage.png)
![alt text](https://github.com/rahimDZ/UI-Unit-Tests-iOS/blob/master/screens/xcodebuild_tests.png)
![alt text](https://github.com/rahimDZ/UI-Unit-Tests-iOS/blob/master/screens/xcodebuild_html_reports_tests.png)
![alt text](https://github.com/rahimDZ/UI-Unit-Tests-iOS/blob/master/screens/slather_code_coverage_reports_tests.png)


## Why do we need a ViewControllerMock?

- [`S.O.L.I.D` Principles](https://en.wikipedia.org/wiki/SOLID_(object-oriented_design)), and more precisely the `D` of `S.O.L.I.D` : [Dependency Inversion Principle](https://en.wikipedia.org/wiki/Dependency_inversion_principle)
- Mock Business Logic Layer to test only UI
- Have access to the outlets and be able to test them.
- override some methods to be able to test it like `prepareForSegue`, the display of an alert error etc...
- Add some methods only when testing to be able to declare some state like : success, server error and network error.
Or an other example of state in the following scenario `when I access the dashboard and the server retrieve the color red, Then the label in the title must be colored in red`, for this example, we will create a new method on the viewcontrollerMock that will allow us to init the Business Logic with the color red and be able to test the scenario.

⚠️⚠️⚠️ Please see an example [here](https://github.com/rahimDZ/UI-Unit-Tests-iOS/blob/master/UI-UnitTests-iOSTests/Dashboard/DashboardViewControllerMock.swift) ⚠️⚠️⚠️


## Python Script Generator

### What is this script and what it really does?
The [script generator](https://github.com/rahimDZ/UI-Unit-Tests-iOS/blob/master/UI-UnitTests-iOS/Script/scriptTest.py) allows to mock one or multiple viewcontroller(s) and also storyboard reference in a specific storyboard.

As you already know, a viewcontroller in a storyboard is "statically" set in the custom class section and also its Storyboard ID identity.
So, the python script will dynamically update the custom class section and the storyboard ID identity with the mocked one.

And so, on the UI-Unit Tests you will be able to create a new viewcontroller "Mocked" that will inherit the one that you want to test to be able to stub the Business logic part and by the way have all the outlets and methods to be tested.

We will see that more precissely on the [Usage section](#usage).

## Requirements

- iOS 8.0+ / macOS 10.10+
- Xcode 8.3+
- Swift 2.3+

To be able to launch the Python script, you will have to install some dependencies :

- [Python 2.7.10+](https://www.python.org/downloads/) (but normally it is installed automatically by xcode)
- Sh: In terminal run : `sudo pip install sh`
- Enum34: In terminal run `sudo pip install --upgrade pip enum34`
- Pip: In terminal run `curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && sudo python get-pip.py`

#TODO: install automatically all dependencies.

## Installation

You only need to get and drag and drop the [script generator](https://github.com/rahimDZ/UI-Unit-Tests-iOS/blob/master/UI-UnitTests-iOS/Script/scriptTest.py) on your xcode project.

After that, you need to go to your target Build phase and add a new "run script" and run the script like in the example : `python $PROJECT_DIR/UI-UnitTests-iOS/Script/scriptTest.py`.

![alt text](https://github.com/rahimDZ/UI-Unit-Tests-iOS/blob/master/screens/build_phase_run_script.png)

## Usage

Here we will see how to use the script generator to mock for instance here the `Dashboard`.

<img src="https://github.com/rahimDZ/UI-Unit-Tests-iOS/blob/master/screens/PART1.png" width="300">


⚠️⚠️⚠️ On the Unit Test folder/Target (and not the UI Tests folder/Target) ⚠️⚠️⚠️

1. Create Folder `Dashboard`

<img src="https://github.com/rahimDZ/UI-Unit-Tests-iOS/blob/master/screens/PART2.png" width="300">

2. On this Folder create an empty Storyboard with the same name as the storyboard that we want to "Mock", in our case `DashboardMock.storyboard`
<img src="https://github.com/rahimDZ/UI-Unit-Tests-iOS/blob/master/screens/PART3.png" width="300">

3. Create a `Cocoa Touch Class` file that will be a subclass of your controller, in our case is a subclass of `DashboardViewController` and the file name will be like `DashboardViewControllerMock.swift`
⚠️⚠️⚠️ Don't forget to add `@testable import YOUR_TARGET_NAME` to all your future mocked controllers ⚠️⚠️⚠️
<img src="https://github.com/rahimDZ/UI-Unit-Tests-iOS/blob/master/screens/PART4.png">
<img src="https://github.com/rahimDZ/UI-Unit-Tests-iOS/blob/master/screens/PART5.png" width="300">
<img src="https://github.com/rahimDZ/UI-Unit-Tests-iOS/blob/master/screens/PART6.png">

4. Update on the Enum on the [script generator](https://github.com/rahimDZ/UI-Unit-Tests-iOS/blob/master/UI-UnitTests-iOS/Script/scriptTest.py) by adding the folder name associated to an array of strings corresponding to the controllers and storyboard references inside the storyboard (because a storyboard can have multiple views and storyboard references).

This is the format of the Enum that needed to be updated as following:
```Python
class ModulesNames(Enum):
    FOLDER_NAME_1 = ["VIEWCONTROLLER1", "VIEWCONTROLLER2", "STORYBOARD_REFERENCE1", "STORYBOARD_REFERENCE2"]
    FOLDER_NAME_2 = ["VIEWCONTROLLER1", "STORYBOARD_REFERENCE1"]
    
    def getKey(self):
        return self.name
```

In our case, we will add the `Dashboard` folder and we need to mock the `DashboardViewController` and the `Calculator` storyboard reference.

<img src="https://github.com/rahimDZ/UI-Unit-Tests-iOS/blob/master/screens/PART7.png">

⚠️⚠️⚠️ Don't forget to call the function `updateStoryboardForModule(ModulesNames.YOUR_FOLDER_NAME)` ⚠️⚠️⚠️

Now, we need to call `updateStoryboardForModule(ModulesNames.Dashboard)` to be able to run the script function for the `Dashboard` folder.

<img src="https://github.com/rahimDZ/UI-Unit-Tests-iOS/blob/master/screens/PART8.png">


5. If we go back to our empty `DashboardMock.storyboard` file, we check that it's really empty:
<img src="https://github.com/rahimDZ/UI-Unit-Tests-iOS/blob/master/screens/PART9.png">

Now Launch a simple build (⌘ + B), it will launch automatically the script generator, because we already add a "run script" on the target "Build Phases".

Our empty `DashboardMock.storyboard` file is already updated with the content of the `Dashboard.storyboard` file and also mocked as we describe in the Enum in the script.

<img src="https://github.com/rahimDZ/UI-Unit-Tests-iOS/blob/master/screens/PART10.png">

## Credits

The [generator script](https://github.com/rahimDZ/UI-Unit-Tests-iOS/blob/master/UI-UnitTests-iOS/Script/scriptTest.py) and its content is owned and maintained by [myself](https://github.com/rahimDZ).

You can contact me on my email: abderrahim.benmakhlouf@gmail.com.

## License

The [generator script](https://github.com/rahimDZ/UI-Unit-Tests-iOS/blob/master/UI-UnitTests-iOS/Script/scriptTest.py) and its content is released under the MIT license.

[See LICENSE](https://github.com/rahimDZ/UI-Unit-Tests-iOS/blob/master/LICENSE) for details.
