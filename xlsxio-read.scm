[module 
  xlsxio-read
  *
  (import scheme chicken foreign)
  
  (foreign-declare "#include <xlsxio_read.h>
                    #include <sys/fcntl.h>
                    xlsxioreader xlsxioread;
                    xlsxioreadersheetlist sheetlist;
                    xlsxioreadersheet sheet;
                    XLSXIOCHAR* value;
                    int filehandle = -1;")

  (define open-xlsx
    (foreign-lambda* number ((c-string filename))
      "
      if (sheet)
      {sheet=NULL;}
      if (sheetlist)
      {sheetlist=NULL;}
      filehandle = 0;
      if ((filehandle = open(filename, O_RDONLY, 0)) == -1) {
        fprintf(stderr, \"Error opening .xlsx file\\n\");
        C_return(1);
      }
      if ((xlsxioread = xlsxioread_open_filehandle(filehandle)) == NULL) {
        fprintf(stderr, \"Error opening open filehandle as .xlsx file.\\n\");
        C_return(1);
      }
      C_return(0);"))

  (define open-sheet-list
    (foreign-lambda* void ()
      "if (xlsxioread)
      {sheetlist = xlsxioread_sheetlist_open(xlsxioread);}"))

  (define next-sheet-name 
    (foreign-lambda* c-string ()
      "if (!sheetlist)
      {C_return(0);}
      C_return(xlsxioread_sheetlist_next(sheetlist));"))
 
  (define open-sheet
    (foreign-lambda* number ((c-string sheetname))
      "if (sheet)
      {xlsxioread_sheet_close(sheet);}
      if (filehandle!=-1 && xlsxioread)
      {sheet = xlsxioread_sheet_open(xlsxioread, sheetname, XLSXIOREAD_SKIP_EMPTY_ROWS);}"))

  (define next-row
    (foreign-lambda* int ()
      "if (!sheet)
       {C_return(-1);}
       C_return(xlsxioread_sheet_next_row(sheet));"))

  (define cell-val
    (foreign-lambda* c-string()
      "if (!sheet)
       {C_return(\"\");}
       C_return(xlsxioread_sheet_next_cell(sheet));"))


  (define close-sheet
    (foreign-lambda* void ()
      "if (sheet)
      {
         xlsxioread_sheet_close(sheet);
         sheet = NULL;
      }"))
    
  (define close-sheet-list
    (foreign-lambda* void ()
      "if (sheetlist)
      {
        xlsxioread_sheetlist_close(sheetlist);
        sheetlist = NULL;
      }"))
      
  (define close-xlsx
    (foreign-lambda* int ()
      "if (sheet)
      {
         xlsxioread_sheet_close(sheet);
         sheet = NULL;
      }
      if (sheetlist)
      {
         xlsxioread_sheetlist_close(sheetlist);
         sheetlist = NULL;
      }      
      filehandle = 0;
      if (xlsxioread)
      {
         xlsxioread_close(xlsxioread);
         xlsxioread = NULL;
      }
      C_return(0);"))]



