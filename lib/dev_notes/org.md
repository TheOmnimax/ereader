# eReader file organization

**main.dart**: Main file

## epub_parser

Files used for the retrieval, parsing, and reading of .epub files.

**epub_parser.dart**: Uses the data retrieved from **epubx_implementation.dart** to retrieve info about the .epub file.

**epubx_implementation.dart**: Used the **epubx** package to parse the .epub file.

**extract.dart**: Retrieves files stored in the app.

## file_explorer

For organizing ebooks, opening them when ready.

**doc_selection.dart**: Tools used to display a list of available ebooks and information about them.

**ebook_metadata.dart**: Metadata about the ebook for the purpose of displaying it in the selection screen, such as the title and author.

**ebook_storage.dart**: Retrieves the ebook, and stores it for when ready to use in the eReader.

## screens

Independent screens that will be used in the app.

**custom_style.dart**: Main page for creating a custom preset.

**ereader.dart**: Soul of the app, the actual eReader, displaying the text of the book.

**selection_page.dart**: Where the user selects the ebook they would like to read.

## shared_widgets

Widgets used in multiple files

**color_selecion.dart**: For selecting color in presets.

**main_scaffold.dart**: Main scaffold used in multiple screens to give consistency.
