#lang racket

(require rackunit/text-ui
         rackunit
         racket/runtime-path
         "../../main.rkt")

(define-runtime-path workbook_xml_file "workbook.xml")

(define test-xml
  (test-suite
   "test-workbook"

   (test-case
    "test-workbook"

    (let ([xml_hash (xml-file-to-hash
                     workbook_xml_file
                     '(
                       "workbook.xmlns"
                       "workbook.xmlns:r"
                       "workbook.fileVersion.appName"
                       "workbook.fileVersion.lastEdited"
                       "workbook.fileVersion.lowestEdited"
                       "workbook.fileVersion.rupBuild"
                       "workbook.workbookPr.filterPrivacy"
                       "workbook.workbookPr.defaultThemeVersion"
                       "workbook.bookViews.workbookView.xWindow"
                       "workbook.bookViews.workbookView.yWindow"
                       "workbook.bookViews.workbookView.windowWidth"
                       "workbook.bookViews.workbookView.windowHeight"
                       "workbook.calcPr.calcId"
                       "workbook.sheets.sheet.name"
                       "workbook.sheets.sheet.sheetId"
                       "workbook.sheets.sheet.r:id"
                       ))])

      (check-equal? (hash-ref xml_hash "workbook1.xmlns1") "http://schemas.openxmlformats.org/spreadsheetml/2006/main")
      (check-equal? (hash-ref xml_hash "workbook1.xmlns:r1") "http://schemas.openxmlformats.org/officeDocument/2006/relationships")

      (check-equal? (hash-ref xml_hash "workbook1.fileVersion1.appName1") "xl")
      (check-equal? (hash-ref xml_hash "workbook1.fileVersion1.lastEdited1") "4")
      (check-equal? (hash-ref xml_hash "workbook1.fileVersion1.lowestEdited1") "4")
      (check-equal? (hash-ref xml_hash "workbook1.fileVersion1.rupBuild1") "4505")

      (check-equal? (hash-ref xml_hash "workbook1.workbookPr1.filterPrivacy1") "1")

      (check-equal? (hash-ref xml_hash "workbook1.workbookPr1.defaultThemeVersion1") "124226")
      (check-equal? (hash-ref xml_hash "workbook1.bookViews1.workbookView1.xWindow1") "0")
      (check-equal? (hash-ref xml_hash "workbook1.bookViews1.workbookView1.yWindow1") "90")
      (check-equal? (hash-ref xml_hash "workbook1.bookViews1.workbookView1.windowWidth1") "19200")
      (check-equal? (hash-ref xml_hash "workbook1.bookViews1.workbookView1.windowHeight1") "10590")

      (check-equal? (hash-ref xml_hash "workbook1.calcPr1.calcId1") "124519")

      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet1.name1") "DataSheet")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet2.name1") "DataSheetWithStyle")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet3.name1") "DataSheetWithStyle2")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet4.name1") "LineChart1")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet5.name1") "LineChart2")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet6.name1") "LineChart3D")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet7.name1") "BarChart")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet8.name1") "BarChart3D")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet9.name1") "PieChart")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet10.name1") "PieChart3D")

      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet1.sheetId1") "1")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet2.sheetId1") "2")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet3.sheetId1") "3")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet4.sheetId1") "4")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet5.sheetId1") "5")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet6.sheetId1") "6")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet7.sheetId1") "7")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet8.sheetId1") "8")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet9.sheetId1") "9")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet10.sheetId1") "10")

      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet1.r:id1") "rId1")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet2.r:id1") "rId2")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet3.r:id1") "rId3")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet4.r:id1") "rId4")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet5.r:id1") "rId5")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet6.r:id1") "rId6")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet7.r:id1") "rId7")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet8.r:id1") "rId8")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet9.r:id1") "rId9")
      (check-equal? (hash-ref xml_hash "workbook1.sheets1.sheet10.r:id1") "rId10")

      )
    )

  ))

(run-tests test-xml)
