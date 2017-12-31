# mainscript
The scripts that install and run all the packages needed to extract IGT from pdf files

## Requirements

`install.sh` requires the following programs to be installed before it is run:

- Python 3
- pip3
- Python 3 development tools (likely `python3-dev` or `python3-devel` in a package manager)
- [virtualenv][]

`pipeline.sh` requires the following programs to be installed before it is run:

- Python 3
- Python 3 TkInter support (likely `python3-tk` in a package manager)
	- not used, but will cause a crash if not installed
- [virtualenv][]

## Packages installed

`install.sh` installs the following packages in a virtual environment, along with their dependencies:

- [PDFMiner][] (as PDFMiner.six)
- [Freki][]
- [igtdetect][]
- [lgid][]

## Usage

Run `./install.sh` to install all the packages.

Run `./pipeline.sh <pdf-file> <output-dir>` to run the pipeline. `<pdf-file>` is the path
to the PDF file to run the pipeline on, and `<output-dir>` is the directory to place
the various output files into.

[virtualenv]: https://virtualenv.pypa.io/
[ODIN]: http://depts.washington.edu/uwcl/odin/
[PDFMiner]: https://github.com/pdfminer/pdfminer.six
[Freki]: https://github.com/xigt/freki
[igtdetect]: https://github.com/xigt/igtdetect
[lgid]: https://github.com/xigt/lgid
