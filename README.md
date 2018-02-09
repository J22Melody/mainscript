# mainscript
The scripts that install and run all the packages needed to extract IGT from pdf files

## Requirements

`install.sh` requires the following programs to be installed before it is run:

- Python 3
- pip3
- Python 3 development tools (likely `python3-dev` or `python3-devel` in a package manager)
- [virtualenv][]
- unzip (Unix utility, likely `unzip` in a package manager)

`pipeline.sh` requires the following programs to be installed before it is run:

- Python 3
- Python 3 TkInter support (likely `python3-tk` in a package manager)
	- not explicitly used, but will cause a crash if not installed
- [virtualenv][]

## Packages installed

`install.sh` installs the following packages in a virtual environment, along with their dependencies:

- [PDFMiner][] (as PDFMiner.six)
- [Freki][]
- [igtdetect][]
- [lgid][]

## Usage

Run `./install.sh` to install all the packages. This script downloads Crubadan language
model files when it installs the `lgid` module, which can significantly increase the
installation time and the size of the installation. Running `./install.sh --no-crubadan`
will skip the downloading of the Crubadan data. Note that using a `lgid` model trained
with the Crubadan language models (as the included ones were) without having the Crubadan
models installed can potentially change the results.

Run `./pdf-pipeline.sh <pdf-file> <output-dir>` to run the pipeline with a PDF input.
`<pdf-file>` is the path to the PDF file to run the pipeline on, and `<output-dir>` is
the directory to place the various output files into.

Run `./text-pipeline.sh <text-file> <output-dir> [<igt-file>]` to run the pipeline with a text input.
`<text-file>` is the path to the PDF file to run the pipeline on, and `<output-dir>` is
the directory to place the various output files into. `[<igt-file>]` is an optional file
specifying locations of IGT instances in the text file. See the documentation for "Plain
Text to Freki Conversion" in the [Freki][] package for information on the format.

Within the given output directory, the script organizes its output files by type:

subdirectory           | contents
-----------------------| -----------
`pdf_out`                | the text files produced by running `PDFMiner` on the PDFs
`freki_out`              | the initial Freki files produced by running `freki` on the text files
`igtdetect_out`          | the Freki files produced by running `igtdetect` on the initial Freki files
`lgid_out`               | the Freki files produced by running `lgid` on the igtdetect Freki files

## Uninstall/Re-Install/Update

To uninstall simply delete the following directories:

- `env`
- `lgid`
- `igtdetect`
- `freki`

This can be done easily by running `rm -rf env lgid igtdetect freki` from the root `mainscript/` directory.

To re-install or update everything follow the uninstall process and then run `install.sh`. Running `install.sh`
only installs missing components; it does not update any already installed modules. To complete or fix an existing
installation with some components missing, you can run `install.sh` without first uninstalling anything.

[virtualenv]: https://virtualenv.pypa.io/
[ODIN]: http://depts.washington.edu/uwcl/odin/
[PDFMiner]: https://github.com/pdfminer/pdfminer.six
[Freki]: https://github.com/xigt/freki
[igtdetect]: https://github.com/xigt/igtdetect
[lgid]: https://github.com/xigt/lgid
