** xlsxio-read **

bindings to libxlsxio that allow one to read excel files from Chicken Scheme.



**dependencies**

1. install expat, libzip, libxlsxio.

2. enter repository directory, type chicken-install

3. to use in Chicken Scheme:


(require-library xlsxio-read)

(use (prefix xlsxio-read xlsxr:)) ;assign xlsxio-read it's own prefix to avoid conflicts 

                                  ;with procedures in xlsxio-write

(xlsxr:open-xlsx "example.xlsx") ;open xlsx file

(xlsxr:open-sheet-list) ;open list of sheets in xlsx file

(xlsxr:next-sheet-name) ;get sheetname n... return #f when no more sheets are found

(xlsxr:close-sheet-list) ;close list of sheets when done

(xlsxr:open-sheet "Sheet1") ;open sheet

(xlsxr:cell-val) ;get cell val n... return #f at beginning and end of every row

(xlsxr:next-row) ;jump to next row 

(xlsxr:close-sheet) ;close sheet

(xlsxr:close-xlsx) ;close file













