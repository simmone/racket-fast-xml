#lang racket

(require rackunit/text-ui
         rackunit
         racket/date
         racket/runtime-path
         "../../main.rkt")

(define-runtime-path sheet_xml_file "sheet.xml")

(define test-xml
  (test-suite
   "test-xml"

   (test-case
    "test-sheet"

    (let ([xml_hash (xml-file-to-hash
                     sheet_xml_file
                     '(
                       "worksheet.xmlns"
                       "worksheet.xmlns:r"
                       "worksheet.dimension.ref"
                       "worksheet.sheetViews.sheetView.selection"
                       "worksheet.sheetViews.sheetView.selection.pane"
                       "worksheet.sheetViews.sheetView.workbookViewId"
                       "worksheet.sheetViews.sheetView.pane"
                       "worksheet.sheetViews.sheetView.pane.ySplit"
                       "worksheet.sheetViews.sheetView.pane.xSplit"
                       "worksheet.sheetViews.sheetView.pane.topLeftCell"
                       "worksheet.sheetViews.sheetView.pane.activePane"
                       "worksheet.sheetViews.sheetView.pane.state"
                       "worksheet.sheetFormatPr.defaultRowHeight"
                       "worksheet.cols.col.min"
                       "worksheet.cols.col.max"
                       "worksheet.cols.col.width"
                       "worksheet.sheetData.row.r"
                       "worksheet.sheetData.row.spans"
                       "worksheet.sheetData.row.c.r"
                       "worksheet.sheetData.row.c.t"
                       "worksheet.sheetData.row.c.v"
                       "worksheet.phoneticPr"
                       "worksheet.phoneticPr.fontId"
                       "worksheet.phoneticPr.type"
                       "worksheet.pageMargins"
                       "worksheet.pageMargins.left"
                       "worksheet.pageMargins.right"
                       "worksheet.pageMargins.top"
                       "worksheet.pageMargins.bottom"
                       "worksheet.pageMargins.header"
                       "worksheet.pageMargins.footer"
                       "worksheet.pageSetup"
                       "worksheet.pageSetup.paperSize"
                       "worksheet.pageSetup.orientation"
                       "worksheet.pageSetup.horizontalDpi"
                       "worksheet.pageSetup.verticalDpi"
                       "worksheet.pageSetup.r:id"
                       ))])

      (check-equal? (hash-ref xml_hash "worksheet1.xmlns1") "http://schemas.openxmlformats.org/spreadsheetml/2006/main")
      (check-equal? (hash-ref xml_hash "worksheet1.xmlns:r1") "http://schemas.openxmlformats.org/officeDocument/2006/relationships")

      (check-equal? (hash-ref xml_hash "worksheet1.dimension1.ref1") "A1:F4")

      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.selection1") "")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.selection2") "")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.selection3") "")

      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.selection1.pane1") "bottomLeft")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.selection2.pane1") "topRight")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.selection3.pane1") "bottomRight")

      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.workbookViewId1") "0")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.pane1") "")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.pane1.ySplit1") "1")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.pane1.xSplit1") "1")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.pane1.topLeftCell1") "B2")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.pane1.activePane1") "bottomRight")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.pane1.state1") "frozen")

      (check-equal? (hash-ref xml_hash "worksheet1.sheetFormatPr1.defaultRowHeight1") "13.5")

      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col1.min1") "1")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col2.min1") "3")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col3.min1") "5")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col4.min1") "6")

      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col1.max1") "2")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col2.max1") "4")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col3.max1") "5")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col4.max1") "6")

      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col1.width1") "50")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col2.width1") "8")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col3.width1") "14")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col4.width1") "8")

      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.r1") "1")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.r1") "2")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.r1") "3")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.r1") "4")

      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.spans1") "1:6")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.spans1") "1:6")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.spans1") "1:6")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.spans1") "1:6")

      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c1.r1") "A1")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c2.r1") "B1")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c3.r1") "C1")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c4.r1") "D1")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c5.r1") "E1")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c6.r1") "F1")

      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c1.r1") "A2")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c2.r1") "B2")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c3.r1") "C2")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c4.r1") "D2")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c5.r1") "E2")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c6.r1") "F2")

      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c1.r1") "A3")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c2.r1") "B3")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c3.r1") "C3")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c4.r1") "D3")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c5.r1") "E3")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c6.r1") "F3")

      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c1.r1") "A4")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c2.r1") "B4")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c3.r1") "C4")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c4.r1") "D4")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c5.r1") "E4")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c6.r1") "F4")

      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c1.t1") "s")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c2.t1") "s")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c3.t1") "s")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c4.t1") "s")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c5.t1") "s")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c6.t1") "s")

      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c1.t1") "s")

      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c1.t1") "s")

      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c1.t1") "s")

      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c1.v1") "16")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c2.v1") "1")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c3.v1") "2")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c4.v1") "3")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c5.v1") "4")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c6.v1") "5")

      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c1.v1") "8")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c2.v1") "100")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c3.v1") "300")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c4.v1") "200")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c5.v1") "0.6934")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c6.v1") "43360")

      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c1.v1") "13")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c2.v1") "200")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c3.v1") "400")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c4.v1") "300")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c5.v1") "139999.89223")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c6.v1") "43361")

      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c1.v1") "6")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c2.v1") "300")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c3.v1") "500")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c4.v1") "400")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c5.v1") "23.34")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c6.v1") "43362")

      (check-equal? (hash-ref xml_hash "worksheet1.phoneticPr1") "")
      (check-equal? (hash-ref xml_hash "worksheet1.phoneticPr1.fontId1") "1")
      (check-equal? (hash-ref xml_hash "worksheet1.phoneticPr1.type1") "noConversion")

      (check-equal? (hash-ref xml_hash "worksheet1.pageMargins1") "")
      (check-equal? (hash-ref xml_hash "worksheet1.pageMargins1.left1") "0.7")
      (check-equal? (hash-ref xml_hash "worksheet1.pageMargins1.right1") "0.7")
      (check-equal? (hash-ref xml_hash "worksheet1.pageMargins1.top1") "0.75")
      (check-equal? (hash-ref xml_hash "worksheet1.pageMargins1.bottom1") "0.75")
      (check-equal? (hash-ref xml_hash "worksheet1.pageMargins1.header1") "0.3")
      (check-equal? (hash-ref xml_hash "worksheet1.pageMargins1.footer1") "0.3")

      (check-equal? (hash-ref xml_hash "worksheet1.pageSetup1") "")
      (check-equal? (hash-ref xml_hash "worksheet1.pageSetup1.paperSize1") "9")
      (check-equal? (hash-ref xml_hash "worksheet1.pageSetup1.orientation1") "portrait")
      (check-equal? (hash-ref xml_hash "worksheet1.pageSetup1.horizontalDpi1") "200")
      (check-equal? (hash-ref xml_hash "worksheet1.pageSetup1.verticalDpi1") "200")
      (check-equal? (hash-ref xml_hash "worksheet1.pageSetup1.r:id1") "rId1")
      ))

   (test-case
    "write-sheet-xml"

    (let ([xml '("worksheet"
                 ("xmlns" . "http://schemas.openxmlformats.org/spreadsheetml/2006/main")
                 ("xmlns:r" . "http://schemas.openxmlformats.org/officeDocument/2006/relationships")
                 ("dimension" ("ref". "A1:F4"))
                 ("sheetViews"
                  ("sheetView"
                   ("workbookViewId" . "0")
                   ("pane" ("ySplit" . "1") ("xSplit" . "1") ("topLeftCell" . "B2") ("activePane" . "bottomRight") ("state" . "frozen"))
                   ("selection" ("pane" . "bottomLeft"))
                   ("selection" ("pane" . "topRight"))
                   ("selection" ("pane" . "bottomRight"))))
                 ("sheetFormatPr" ("defaultRowHeight" . "13.5"))
                 ("cols"
                  ("col" ("min" . "1") ("max" . "2") ("width" . "50"))
                  ("col" ("min" . "3") ("max" . "4") ("width" . "8"))
                  ("col" ("min" . "5") ("max" . "5") ("width" . "14"))
                  ("col" ("min" . "6") ("max" . "6") ("width" . "8")))
                 ("sheetData"
                  ("row" ("r" . "1") ("spans" . "1:6")
                   ("c" ("r" . "A1") ("t" . "s") ("v" "16"))
                   ("c" ("r" . "B1") ("t" . "s") ("v" "1"))
                   ("c" ("r" . "C1") ("t" . "s") ("v" "2"))
                   ("c" ("r" . "D1") ("t" . "s") ("v" "3"))
                   ("c" ("r" . "E1") ("t" . "s") ("v" "4"))
                   ("c" ("r" . "F1") ("t" . "s") ("v" "5")))

                  ("row" ("r" . "2") ("spans" . "1:6")
                   ("c" ("r" . "A2") ("t" . "s") ("v" "8"))
                   ("c" ("r" . "B2") ("v" "100"))
                   ("c" ("r" . "C2") ("v" "300"))
                   ("c" ("r" . "D2") ("v" "200"))
                   ("c" ("r" . "E2") ("v" "0.6934"))
                   ("c" ("r" . "F2") ("v" "43360")))

                  ("row" ("r" . "3") ("spans" . "1:6")
                   ("c" ("r" . "A3") ("t" . "s") ("v" "13"))
                   ("c" ("r" . "B3") ("v" "200"))
                   ("c" ("r" . "C3") ("v" "400"))
                   ("c" ("r" . "D3") ("v" "300"))
                   ("c" ("r" . "E3") ("v" "139999.89223"))
                   ("c" ("r" . "F3") ("v" "43361")))

                  ("row" ("r" . "4") ("spans" . "1:6")
                   ("c" ("r" . "A4") ("t" . "s") ("v" "6"))
                   ("c" ("r" . "B4") ("v" "300"))
                   ("c" ("r" . "C4") ("v" "500"))
                   ("c" ("r" . "D4") ("v" "400"))
                   ("c" ("r" . "E4") ("v" "23.34"))
                   ("c" ("r" . "F4") ("v" "43362"))))

                 ("phoneticPr" ("fontId" . "1") ("type" . "noConversion"))
                 ("pageMargins" ("left" . "0.7") ("right" . "0.7") ("top" . "0.75") ("bottom" . "0.75") ("header" . "0.3") ("footer" . "0.3"))
                 ("pageSetup" ("paperSize" . "9") ("orientation" . "portrait") ("horizontalDpi" . "200") ("verticalDpi" . "200") ("r:id" . "rId1")))])

      (call-with-input-file sheet_xml_file
        (lambda (p)
          (check-equal? (lists-to-xml xml)
                        (port->string p)))))
  )))

(run-tests test-xml)
