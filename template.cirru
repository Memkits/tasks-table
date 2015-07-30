
var
  stir $ require :stir-template
  (object~ html head title meta link script body div) stir

= module.exports $ \ (data)
  return $ stir.render
    stir.doctype
    html null
      head null
        title null ":Tasks Table"
        meta $ object (:charset :utf-8)
        link $ object (:rel :icon)
          :href :images/tasks-table.png
        link $ object (:rel :stylesheet)
          :href :style/main.css
        cond data.dev
          div null
            script $ {} (:src :node_modules/xlsx/dist/jszip.js)
            script $ {} (:src :node_modules/xlsx/dist/xlsx.core.min.js)
          div null
            script $ {} (:src :http://oss.sheetjs.com/js-xlsx/jszip.js)
            script $ {} (:src :http://oss.sheetjs.com/js-xlsx/xlsx.core.min.js)
        script $ object (:src data.vendor) (:defer true)
        script $ object (:src data.main) (:defer true)
      body null
