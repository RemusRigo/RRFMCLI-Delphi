# RRFMCLI: User's Guide



## Downloads & Runtimes

Download the latest release from the [Releases page](https://github.com/RemusRigo/RRFMCLI-Delphi/releases).

|File|Architecture|Required Runtime|
|-|-|-|
|`RRFMCLI.exe`|32-bit|none (native Windows console app)|



## Install

Copy `RRFMCLI.exe` to a folder, for example `D:\My Apps\RRFMCLI\`.
To run it from any folder, add that folder to your `PATH`.



## Usage

```
RRFMCLI /UF /source:<sourcefile> /search:<searchpath>
RRFMCLI /H
```

|Switch|Description|
|-|-|
|`/UF`|Update file: copy the source file over every file with the **same name** found in the search path and its subfolders|
|`/source:<sourcefile>`|The source file, with its path|
|`/search:<searchpath>`|The folder to search (subfolders included)|
|`/H`|Show the help|

The switches must be given in this order. Wrap paths with spaces in quotes.

Example: update every `config.ini` under `D:\Sites` with `D:\Templates\config.ini`:

```
RRFMCLI /UF "/source:D:\Templates\config.ini" "/search:D:\Sites"
```

Output:

```
#1: D:\Sites\Site1\config.ini
#2: D:\Sites\Site2\config.ini

Total files updated: 2
```

> **Warning:** the files are overwritten without asking and there is no undo. Make a backup first.



## Uninstall

Delete `RRFMCLI.exe`.
