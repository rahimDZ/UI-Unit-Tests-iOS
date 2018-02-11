# # UI UnitTests iOS
A new way to test your UI very quicly with unit tests by mocking the Business logic.
This new way use a storyboard generator that mock the storyboard and replacing a mocked viewcontroller that inherit from the viewcontroller that you want to test.

- [Python Script Generator](#python-script-generator)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Credits](#credits)
- [License](#license)

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


## Credits

The [generator script](https://github.com/rahimDZ/UI-Unit-Tests-iOS/blob/master/UI-UnitTests-iOS/Script/scriptTest.py) and its content is owned and maintained by [me](https://github.com/rahimDZ). You can contact me on my email: abderrahim.benmakhlouf@gmail.com.

## License

The [generator script](https://github.com/rahimDZ/UI-Unit-Tests-iOS/blob/master/UI-UnitTests-iOS/Script/scriptTest.py) and its content is released under the MIT license. [See LICENSE](https://github.com/rahimDZ/UI-Unit-Tests-iOS/blob/master/LICENSE) for details.
