**Python Virtual Environment Manager**
=====================================

**Overview**
------------

This script helps you create and manage Python virtual environments with multiple Python installations on your system. It lists all available Python versions, allows you to select one, and creates a new project directory with a virtual environment using the selected Python version. If you're not used to the Windows command line and programming Batch scripts, you should use something like Conda instead, which won't be as confusing.

**Features**
------------

* Lists all installed Python versions and allows you to select one
* Creates a new project folder and initializes a virtual environment
* Automatically upgrades pre-installed dependencies
* Creates a new Python script file with the appropriate shebang line
* Activates the virtual environment and opens the script in Notepad++

**Requirements**
---------------

* Python installed with multiple versions (detected via `py -0`)
* Notepad++ for editing Python scripts

**Getting Started**
-------------------

1. Simply double-click on the `new_python_environment.bat` file.
2. Follow the prompts to select a Python version and create a new project.

**Using the Script**
--------------------

1. Type your Python code in the Notepad++ file, save, then run by typing `python run.py` at the virtual environment command line and hitting Enter.
2. Install packages, or show them with `pip list` as normal.
3. When done, you can `deactivate` or `exit` to end.
4. Open the same project simply by running the script again. Just enter the same name you used to create it.
