# freespace
You are required to write a bash script called "freespace" which can (recursively) traverse a folder of files - often log files - and free the space they are taking by:    1. Zipping them, and removing the original. 2. Deleting "old" zips.
You are required to write a bash script called "freespace" which can (recursively) traverse a folder of files - often log files - and free the space they are taking by:  

1. Zipping them, and removing the original.
2. Deleting "old" zips.

  

### Following is a synopsis of the script:

- Usage: `freespace [-r] [-t ###] file [file...]`
- If file is not compressed - The script will zip it under name `fc-<origname>`.
- If file is compressed - The script will `mv` the file to name `fc-<origname>` and `touch` it.
- If a file is called `fc-*` AND is older than 48 hours - The script will `rm` it.
- If file is a folder - The script will go over all non-folder files in the folder.
- If in recursive mode - The script will also follow sub-folders recursively.

### Flags:

- `-r` Recursive mode.
- `-t` Alternative timeout in hours. The default value is 48.

  

### Notes:

- A file is considered "compressed" (no need to zip further) if it is zipped, tgzed, bzipped or compressed.

> The asterisk (`*`) symbol in the instructions is a GLOB expression which represents "zero or more characters".

- You can assume that all files named `fc-*` are actually named by you. No need to worry about deleting them once they are "old".

  
Use [[Getopts]]
## To hand-in

Upload your "freespace.sh" script in the following lesson/quiz.





