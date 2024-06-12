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
                       ("workbook.xmlns" . a)
                       ("workbook.xmlns:r" . a)
                       ("workbook.fileVersion.appName" . a)
                       ("workbook.fileVersion.lastEdited" . a)
                       ("workbook.fileVersion.lowestEdited" . a)
                       ("workbook.fileVersion.rupBuild" . a)
                       ("workbook.workbookPr.filterPrivacy" . a)
                       ("workbook.workbookPr.defaultThemeVersion" . a)
                       ("workbook.bookViews.workbookView.xWindow" . a)
                       ("workbook.bookViews.workbookView.yWindow" . a)
                       ("workbook.bookViews.workbookView.windowWidth" . a)
                       ("workbook.bookViews.workbookView.windowHeight" . a)
                       ("workbook.calcPr.calcId" . a)
                       ("workbook.sheets.sheet.name" . a)
                       ("workbook.sheets.sheet.sheetId" . a)
                       ("workbook.sheets.sheet.r:id" . a)
                       ))])
      (check-equal? (hash-ref xml_hash "workbook.xmlns") '("http://schemas.openxmlformats.org/spreadsheetml/2006/main"))
      (check-equal? (hash-ref xml_hash "workbook.xmlns:r") '("http://schemas.openxmlformats.org/officeDocument/2006/relationships"))
      (check-equal? (hash-ref xml_hash "workbook.fileVersion.appName") '("xl"))
      (check-equal? (hash-ref xml_hash "workbook.fileVersion.lastEdited") '("4"))
      (check-equal? (hash-ref xml_hash "workbook.fileVersion.lowestEdited") '("4"))
      (check-equal? (hash-ref xml_hash "workbook.fileVersion.rupBuild") '("4505"))
      (check-equal? (hash-ref xml_hash "workbook.workbookPr.filterPrivacy") '("1"))
      (check-equal? (hash-ref xml_hash "workbook.workbookPr.defaultThemeVersion") '("124226"))
      (check-equal? (hash-ref xml_hash "workbook.bookViews.workbookView.xWindow") '("0"))
      (check-equal? (hash-ref xml_hash "workbook.bookViews.workbookView.yWindow") '("90"))
      (check-equal? (hash-ref xml_hash "workbook.bookViews.workbookView.windowWidth") '("19200"))
      (check-equal? (hash-ref xml_hash "workbook.bookViews.workbookView.windowHeight") '("10590"))
      (check-equal? (hash-ref xml_hash "workbook.calcPr.calcId") '("124519"))
      (check-equal? (hash-ref xml_hash "workbook.sheets.sheet.name") '("DataSheet" "DataSheetWithStyle" "DataSheetWithStyle2"
                                                                       "LineChart1" "LineChart2" "LineChart3D"
                                                                       "BarChart" "BarChart3D" "PieChart" "PieChart3D"))
      (check-equal? (hash-ref xml_hash "workbook.sheets.sheet.sheetId") '("1" "2" "3" "4" "5" "6" "7" "8" "9" "10"))
      (check-equal? (hash-ref xml_hash "workbook.sheets.sheet.r:id") '("rId1" "rId2" "rId3" "rId4" "rId5" "rId6" "rId7" "rId8" "rId9" "rId10"))
      )

    )

  ))

(run-tests test-xml)
