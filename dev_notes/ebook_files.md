# eBook files

## Organization

All eBook files should be stored in the folder "/assets/ebook_files/".

## File names

All files names should be lowercase. All spaces should be replaced with underscores.

They will follow this format:

* Book unique identifier
* Hyphen
* Author surname
* Comma (or underscore if name order is surname-given name)
* Author given name
* If the author uses middle names or hyphens, put them after the given name, with underscores between each part.
* If multiple authors, list them as well, separated by semicolons
* Hyphen
* Title; if it begins with "The", "A", or "An", that should be moved to the end of the title, with a comma between them.
* Hyphen
* Book unique identifier

Example:

    martin,george_r._r.-game_of_thrones,a-000000-0000-0000.epub

## Unique identifier

The unique identifier is in three parts, each separated by a hyphen. Each part is a hexadecimal code:

* Part 1: Author ID, 6 characters (each author ID is unique)
* Part 2: Book ID, four characters (unique to that author, but can be shared by other authors)
* Part 3: Publisher ID (four characters) (each publisher ID is unique)

If there are multiple authors, there should be an author ID unique to that group. For example, 000000 may be for George R. R. Martin, and 000001 may be for Gardner Dozois, but their collaboration will be 000002.