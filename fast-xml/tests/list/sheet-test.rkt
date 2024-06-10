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
                       ("worksheet" . v)
                       ("worksheet.xmlns" . a)
                       ("worksheet.xmlns:r" . a)
                       ("worksheet.dimension" . v)
                       ("worksheet.dimension.ref" . a)
                       ("worksheet.sheetViews" . v)
                       ("worksheet.sheetViews.sheetView" . v)
                       ("worksheet.sheetViews.sheetView.selection" . v)
                       ("worksheet.sheetViews.sheetView.selection.pane" . a)
                       ("worksheet.sheetViews.sheetView.workbookViewId" . a)
                       ("worksheet.sheetViews.sheetView.pane" . v)
                       ("worksheet.sheetViews.sheetView.pane.ySplit" . a)
                       ("worksheet.sheetViews.sheetView.pane.xSplit" . a)
                       ("worksheet.sheetViews.sheetView.pane.topLeftCell" . a)
                       ("worksheet.sheetViews.sheetView.pane.activePane" . a)
                       ("worksheet.sheetViews.sheetView.pane.state" . a)
                       ("worksheet.sheetFormatPr" . v)
                       ("worksheet.sheetFormatPr.defaultRowHeight" . a)
                       ("worksheet.cols" . v)
                       ("worksheet.cols.col" . v)
                       ("worksheet.cols.col.min" . a)
                       ("worksheet.cols.col.max" . a)
                       ("worksheet.cols.col.width" . a)
                       ("worksheet.sheetData" . v)
                       ("worksheet.sheetData.row" . v)
                       ("worksheet.sheetData.row.r" . a)
                       ("worksheet.sheetData.row.spans" . a)
                       ("worksheet.sheetData.row.c" . v)
                       ("worksheet.sheetData.row.c.r" . a)
                       ("worksheet.sheetData.row.c.t" . a)
                       ("worksheet.sheetData.row.c.v" . v)
                       ("worksheet.phoneticPr" . v)
                       ("worksheet.phoneticPr.fontId" . a)
                       ("worksheet.phoneticPr.type" . a)
                       ("worksheet.pageMargins" . v)
                       ("worksheet.pageMargins.left" . a)
                       ("worksheet.pageMargins.right" . a)
                       ("worksheet.pageMargins.top" . a)
                       ("worksheet.pageMargins.bottom" . a)
                       ("worksheet.pageMargins.header" . a)
                       ("worksheet.pageMargins.footer" . a)
                       ("worksheet.pageSetup" . v)
                       ("worksheet.pageSetup.paperSize" . a)
                       ("worksheet.pageSetup.orientation" . a)
                       ("worksheet.pageSetup.horizontalDpi" . a)
                       ("worksheet.pageSetup.verticalDpi" . a)
                       ("worksheet.pageSetup.r:id" . a)
                       ))])

;      (check-equal? (hash-ref xml_hash "worksheet") '(""))
      (check-equal? (hash-ref xml_hash "worksheet.xmlns") '("http://schemas.openxmlformats.org/spreadsheetml/2006/main"))
      (check-equal? (hash-ref xml_hash "worksheet.xmlns:r") '("http://schemas.openxmlformats.org/officeDocument/2006/relationships"))

      (check-equal? (hash-ref xml_hash "worksheet.dimension") '(""))
      (check-equal? (hash-ref xml_hash "worksheet.dimension.ref") '("A1:F4"))

;      (check-equal? (hash-ref xml_hash "worksheet.sheetViews") '(""))
;      (check-equal? (hash-ref xml_hash "worksheet.sheetViews.sheetView") '(""))

      (check-equal? (hash-ref xml_hash "worksheet.sheetViews.sheetView.selection") '("" "" ""))
      (check-equal? (hash-ref xml_hash "worksheet.sheetViews.sheetView.selection.pane") '("bottomLeft" "topRight" "bottomRight"))

      (check-equal? (hash-ref xml_hash "worksheet.sheetViews.sheetView.workbookViewId") '("0"))
      (check-equal? (hash-ref xml_hash "worksheet.sheetViews.sheetView.pane") '(""))
      (check-equal? (hash-ref xml_hash "worksheet.sheetViews.sheetView.pane.ySplit") '("1"))
      (check-equal? (hash-ref xml_hash "worksheet.sheetViews.sheetView.pane.xSplit") '("1"))
      (check-equal? (hash-ref xml_hash "worksheet.sheetViews.sheetView.pane.topLeftCell") '("B2"))
      (check-equal? (hash-ref xml_hash "worksheet.sheetViews.sheetView.pane.activePane") '("bottomRight"))
      (check-equal? (hash-ref xml_hash "worksheet.sheetViews.sheetView.pane.state") '("frozen"))

      (check-equal? (hash-ref xml_hash "worksheet.sheetFormatPr") '(""))
      (check-equal? (hash-ref xml_hash "worksheet.sheetFormatPr.defaultRowHeight") '("13.5"))

;      (check-equal? (hash-ref xml_hash "worksheet.cols") '(""))
      (check-equal? (hash-ref xml_hash "worksheet.cols.col") '("" "" "" ""))

      (check-equal? (hash-ref xml_hash "worksheet.cols.col") '("" "" "" ""))
      (check-equal? (hash-ref xml_hash "worksheet.cols.col.min") '("1" "3" "5" "6"))
      (check-equal? (hash-ref xml_hash "worksheet.cols.col.max") '("2" "4" "5" "6"))
      (check-equal? (hash-ref xml_hash "worksheet.cols.col.width") '("50" "8" "14" "8"))

;      (check-equal? (hash-ref xml_hash "worksheet.sheetData") '(""))
;      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row") '("" "" "" ""))

      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row.r") '("1" "2" "3" "4"))
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row.spans") '("1:6" "1:6" "1:6" "1:6"))
;      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row.c") '("" "" "" ""))
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row.c.r") '("A1" "B1" "C1" "D1" "E1" "F1"
                                                                        "A2" "B2" "C2" "D2" "E2" "F2"
                                                                        "A3" "B3" "C3" "D3" "E3" "F3"
                                                                        "A4" "B4" "C4" "D4" "E4" "F4"
                                                                        ))
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row.c.t") '(
                                                                        "s" "s" "s" "s" "s" "s"
                                                                        "s" ""  ""  ""  ""  ""
                                                                        "s" ""  ""  ""  ""  ""
                                                                        "s" ""  ""  ""  ""  ""
                                                                        ))
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row.c.v") '(
                                                                        "16" "1" "2" "3" "4" "5"
                                                                        "8" "100" "300" "200" "0.6934" "43360"
                                                                        "13" "200" "400" "300" "139999.89223" "43361"
                                                                        "6" "300" "500" "400" "23.34" "43362"
                                                                        ))

      (check-equal? (hash-ref xml_hash "worksheet.phoneticPr") '(""))
      (check-equal? (hash-ref xml_hash "worksheet.phoneticPr.fontId") '("1"))
      (check-equal? (hash-ref xml_hash "worksheet.phoneticPr.type") '("noConversion"))

      (check-equal? (hash-ref xml_hash "worksheet.pageMargins") '(""))
      (check-equal? (hash-ref xml_hash "worksheet.pageMargins.left") '("0.7"))
      (check-equal? (hash-ref xml_hash "worksheet.pageMargins.right") '("0.7"))
      (check-equal? (hash-ref xml_hash "worksheet.pageMargins.top") '("0.75"))
      (check-equal? (hash-ref xml_hash "worksheet.pageMargins.bottom") '("0.75"))
      (check-equal? (hash-ref xml_hash "worksheet.pageMargins.header") '("0.3"))
      (check-equal? (hash-ref xml_hash "worksheet.pageMargins.footer") '("0.3"))

      (check-equal? (hash-ref xml_hash "worksheet.pageSetup") '(""))
      (check-equal? (hash-ref xml_hash "worksheet.pageSetup.paperSize") '("9"))
      (check-equal? (hash-ref xml_hash "worksheet.pageSetup.orientation") '("portrait"))
      (check-equal? (hash-ref xml_hash "worksheet.pageSetup.horizontalDpi") '("200"))
      (check-equal? (hash-ref xml_hash "worksheet.pageSetup.verticalDpi") '("200"))
      (check-equal? (hash-ref xml_hash "worksheet.pageSetup.r:id") '("rId1"))
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
